# Platform architecture

## Goals

- Make secure delivery the easiest path for application teams.
- Centralize pipeline behavior while leaving application-specific build/test commands and deployment configuration in application repositories.
- Keep infrastructure provisioning, artifact creation, and environment promotion separate and auditable.
- Make workflows measurable, versioned, and safe to adopt incrementally.

## Control plane and repository boundaries

Maintain a dedicated framework repository as the source of versioned reusable workflows, composite actions, Terraform modules, and starter templates. Application repositories call workflows by a release tag and own their source, tests, Dockerfile, Helm values, and environment-specific configuration. Pin action dependencies to reviewed immutable commit SHAs in production releases; update them through reviewed dependency updates.

Recommended ownership:

| Capability | Owner | Change control |
|---|---|---|
| Reusable workflows, actions, runner policy | Platform engineering | Protected branches, CODEOWNERS, release tags |
| Shared Terraform modules and EKS baseline | Platform/cloud foundation | Versioned module releases, security review |
| Application code, tests, Dockerfile | Application team | Normal feature branch and pull request |
| Environment values and release approval | App team with environment owners | Protected GitHub environments |
| Security thresholds and exception register | Security/platform | Published policy and time-bound exceptions |

Keep framework releases backward compatible where possible. An app pins `@v1`; breaking changes are released as `@v2`. Use immutable full commit SHAs or protected tags for high-assurance environments, and document upgrade windows and deprecation dates.

## Trust boundaries and runners

### GitHub-hosted runners

Use GitHub-hosted runners for pull-request linting, unit tests, dependency review, and builds that do not need private network access. Pull-request workflows should have read-only repository permissions by default, must not receive deployment credentials, and must not execute privileged steps on untrusted fork code.

### AWS-hosted runners

Use ephemeral runners for private EKS access, Terraform applies, and other jobs that require AWS network reachability. Prefer Actions Runner Controller (ARC) on a dedicated EKS runner cluster, or another managed ephemeral runner service approved by the organization. Separate runner groups by trust level and environment; never share a privileged production runner pool with arbitrary pull-request code. Restrict egress, instance/workload identity, IAM permissions, concurrency, and job duration. Destroy runner capacity after each job.

The runner management plane itself is critical infrastructure. Do not bootstrap or upgrade the only runner pool using jobs that depend on that pool. Retain a break-glass administration path and monitor runner image age, patching, queue time, and utilization.

## Delivery flow

```text
feature branch
  -> pull request: lint, unit tests, dependency/secret/code/IaC checks
  -> protected branch merge
    -> build once -> publish immutable image to ECR -> block until scan passes
    -> sign/attest if required by policy
    -> dev -> qa -> uat -> stg -> prod (same image digest)
         environment policy, tests, and approval at each required boundary
  -> deployment outcome and workflow events -> metrics/dashboard
```

Use branch protection/rulesets to require status checks, reviews, and linear or otherwise controlled merges. `main` should be protected. Feature branches should be short-lived and named consistently (for example `feature/*`, `fix/*`, `chore/*`). Do not deploy directly from a feature branch to shared or production environments. Temporary preview environments may be added later with isolated credentials, quotas, and cleanup.

Build outputs are immutable and addressed by digest. Tags such as commit SHA are useful references, but deployment inputs should use the resolved image digest. Promote the digest between environments; do not rebuild or retag from mutable `latest`.

## Environment promotion

Represent dev, qa, uat, stg, and prod as GitHub Environments, with environment-specific variables, scoped OIDC roles, protection rules, approvers, and deployment concurrency. Keep secrets out of values files and logs. Use the lowest-risk appropriate approval policy; require explicit approval for production and any additional gates mandated by risk or regulation.

Promotion may be automated after successful tests for lower environments. Define evidence required to advance (smoke/integration test outcome, change record if applicable, policy evaluation) and record the artifact digest, source commit, workflow run, deployer identity, and target environment.

## Infrastructure and application responsibilities

- Terraform provisions shared cloud foundations: IAM/OIDC, VPC/network integration, EKS, ECR, runner capacity, logging, and monitoring. Platform owns shared foundations; app teams consume approved modules and isolated state.
- Helm installs and upgrades application releases on existing clusters. Application teams own chart values and release health checks; platform publishes a maintained chart pattern and cluster policy.
- Separate cluster lifecycle from application lifecycle. Do not provision an EKS cluster as a side effect of an application deployment.
- Isolate Terraform state by account/environment and ownership boundary. Use an approved remote backend with encryption, versioning, locking, access logging, and narrowly scoped access.

## Artifact repository choice

ECR is the default for OCI images because it integrates with AWS IAM, scanning, lifecycle policies, and EKS. Use immutable tags and digest deployment; apply encryption, replication, retention, and vulnerability policies centrally.

JFrog Artifactory is complementary rather than required. Adopt it when teams need a governed multi-format repository (for example npm, PyPI, NuGet, Maven), upstream proxy/cache, promotion features, or an existing enterprise standard. Decide which system is authoritative for each package type, define retention and replication, and avoid proxy chains or duplicate publishing that obscure provenance. An organization may use Artifactory for packages while retaining ECR as the runtime image registry.

## Open decisions before implementation

1. GitHub organization, repository naming, rulesets, SSO, and reusable-workflow visibility.
2. AWS account/environment topology, VPC ownership, private connectivity, and region policy.
3. Runner platform: ARC on EKS versus another ephemeral AWS runner service; bootstrap and break-glass ownership.
4. Terraform backend, module registry, state separation, and apply approval model.
5. ECR-only versus Artifactory scope, package types, licenses, scanning, and retention.
6. Security tools, severity thresholds, exception authority, and remediation SLAs.
7. Telemetry destination, data retention, cost allocation labels, and dashboard ownership.
