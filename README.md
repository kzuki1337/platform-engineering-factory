# CI/CD Platform Framework

An adoptable, centrally managed CI/CD framework for application teams using GitHub Actions, AWS, Terraform, EKS, and Helm.

This repository is the platform source of truth. It provides reusable workflows, module contracts and starter modules, application examples, and operating guidance. It is not a turnkey production deployment: account topology, network controls, observability integrations, and organization policies must be supplied by the adopting platform team.

## Start here

- [Platform architecture](docs/architecture.md)
- [Adoption roadmap](docs/adoption-roadmap.md)
- [Security gates and exceptions](docs/security-gates.md)
- [Pipeline metrics and dashboard](docs/metrics.md)
- [Versioning and contribution model](docs/versioning.md)
- [Sharing with application repositories](docs/sharing-with-repos.md)
- [Reusable workflows](.github/workflows/README.md)
- [Terraform modules](terraform/README.md)
- [Application starters](templates/README.md)
- [Helm deployment chart](helm/README.md)

## Repository layout

```text
.github/workflows/       Centrally maintained, reusable GitHub Actions workflows
docs/                    Architecture, adoption, governance, security, and metrics
helm/                    Helm application chart starter
terraform/modules/       Shared Terraform modules
terraform/examples/      Composition examples; supply organization-specific values
templates/               Python (primary), Node.js, and .NET starter applications
```

## Key delivery decisions

1. Pull requests run fast, unprivileged checks. A protected-branch merge creates one immutable artifact and blocks promotion until its ECR vulnerability scan passes.
2. Promote that artifact by digest through dev, qa, uat, stg, and prod. Do not rebuild separately per environment.
3. Use GitHub-hosted runners for general CI and isolated, ephemeral AWS-hosted runners only for private-network or privileged work.
4. Use GitHub OIDC and short-lived AWS roles instead of static AWS keys.
5. Use Terraform for AWS/EKS foundations and Helm for application releases.
6. Use ECR as the default OCI image registry. Add Artifactory when multi-format package management, proxy caching, or existing enterprise standards justify the extra service.

The Python example is the primary app starter and demonstrates the shared Python CI contract, tests, and a non-root container. Node.js and .NET starter templates show how other runtimes consume the same framework.

## Before production adoption

Set organization/repository names, AWS account and network boundaries, Terraform state backend, EKS ownership, runner isolation model, artifact retention, policy thresholds, and telemetry destination. Review the security and operational assumptions in the docs before granting workflows cloud access.
