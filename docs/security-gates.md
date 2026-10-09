# Security and quality gates

Use consistent policy with runtime-appropriate tools. Keep pull-request jobs unprivileged; separate the artifact-publishing and deployment permissions from code validation. Pin third-party actions and tool versions, and review upgrades.

| Gate | Pull request | Protected-branch build | Promotion |
|---|---|---|---|
| Formatting, lint, unit tests | Required | Required | — |
| Dependency manifest/lockfile and license policy | Required; report policy violations | Recheck resolved package set | — |
| Secret detection | Required; no secrets in logs/artifacts | Required | — |
| SAST / code analysis | Required for supported runtimes | Recheck on release branch | — |
| IaC validation and policy | Required for Terraform changes | Required before apply | Re-evaluate relevant plan |
| Container vulnerability scan | Optional pre-build where feasible | Start scan on publish; block promotion until policy passes | Recheck according to freshness policy |
| Image signature/provenance | — | Required before trusted promotion where tooling is available | Verify signature, source, and digest |
| Application smoke/integration tests | As fast and deterministic as possible | Required before dev promotion | Required per environment risk |
| Approval and change evidence | Review approval | — | Environment-specific; required for prod |

## Gate behavior

- Block merge for reproducible correctness failures, exposed secrets, prohibited licenses, and critical/high findings according to the approved policy.
- Begin with report-only or warning mode for noisy scans, baseline existing findings, and publish a dated migration plan before enforcing new thresholds.
- Define severity mapping, exploitability/context exceptions, false-positive handling, remediation SLA, and the decision owner in policy.
- Exceptions must be documented, scoped to a finding and repository, justified, approved by the designated risk owner, and expire automatically or have a review date. Do not create permanent blanket suppressions.
- Preserve reports and attestations as build evidence with retention controls. Do not upload source, credentials, or sensitive logs to unapproved services.

## Credential and workflow controls

- Grant `contents: read` and only the additional permissions needed per job. Use `id-token: write` only in jobs that assume AWS roles.
- Use GitHub OIDC with exact repository and subject/audience conditions; scope role trust to branches or protected environments and restrict IAM actions/resources.
- Use separate AWS roles for image publishing, Terraform plan/apply, and each deployment environment. Do not share production role credentials with build jobs.
- Never use static AWS keys in GitHub secrets. Do not expose secrets to fork-originated pull requests or arbitrary pull-request code.
- Require protected environments and independent approval for production. Consider enforcing self-review prohibition and deployment concurrency.
- Use immutable image digests; verify provenance/signature before production deployment.
- Restrict runner groups, network egress, and concurrency; use ephemeral runners for privileged jobs and destroy them after use.
- Audit changes to reusable workflows, action pins, Terraform modules, IAM policies, and environment protection rules.

## Baseline tools (select enterprise-approved products)

Possible categories include native GitHub dependency review/code scanning, language-native format/lint/test, secret scanning, SAST, dependency/license analysis, Terraform validation/policy, container image scanning, and image signing/attestation. Keep tool selection configurable until licensing, data residency, and current contracts are known; avoid duplicating scanners without a clear ownership and triage model.
