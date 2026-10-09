# Terraform starters

Modules in this repository are versioned independently from application repositories and should be released with semantic versions. Pin registry modules to a tested version; do not consume moving branches in production.

| Starter | Responsibility |
|---|---|
| [`modules/github-oidc-role`](modules/github-oidc-role/) | Trust one exact GitHub OIDC subject and attach only explicitly selected managed policies |
| [`modules/ecr-repository`](modules/ecr-repository/) | Encrypted ECR repository with immutable tags, scan-on-push, and image retention |
| [`examples/eks-foundation`](examples/eks-foundation/) | Composition example using the maintained upstream EKS module with private API access |

## State and apply controls

The examples intentionally do not configure a backend or AWS account. Before use, configure the organization-approved remote state backend with encryption, versioning, locking, audit logging, and isolated state per account/environment/ownership boundary. Restrict plan and apply roles separately; require reviewed plans and explicit production approval.

This starter provides Terraform validation, module contracts, and an EKS composition example; it does not provide a generic plan/apply workflow yet. Implementing apply safely depends on the selected state backend, plan-artifact confidentiality/retention, account boundaries, and approval policy. Do not treat `terraform validate` as an infrastructure deployment gate.

## Runner infrastructure

Runner capacity is intentionally an architecture contract rather than a turnkey Terraform module. Select ARC on a dedicated EKS cluster or an approved ephemeral AWS runner service, then implement account, network, image, autoscaling, and break-glass controls for that platform. Do not deploy privileged runners into an application cluster without a reviewed threat model.

## Validation

The reusable Terraform workflow runs `fmt`, `init -backend=false`, and `validate`. Add organization-approved IaC scanning and policy-as-code gates. Module consumers must also test plans in a sandbox; syntax validation is not a security or compatibility guarantee.
