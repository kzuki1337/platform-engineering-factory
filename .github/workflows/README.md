# Reusable workflow catalog

These workflows are centrally owned and should be released with the framework repository. Callers pin an approved release as described in [versioning](../../docs/versioning.md).

| Workflow | Purpose | Credentials |
|---|---|---|
| `node-ci.yml` | npm install, lint, test, build, audit | None |
| `python-ci.yml` | Install locked dev dependencies, lint, test | None |
| `dotnet-ci.yml` | Restore, format verification, test | None |
| `dependency-review.yml` | Review dependency changes on pull requests | None |
| `terraform-validate.yml` | Format, initialize without backend, validate | None |
| `publish-ecr.yml` | Build/push image tagged with source commit and run identity; return digest | AWS OIDC role |
| `ecr-scan-gate.yml` | Wait for ECR scan results and block configured severity findings | Read-only AWS OIDC role |
| `helm-deploy.yml` | Deploy an image digest into an EKS environment | `AWS_DEPLOY_ROLE_ARN` secret scoped to the named GitHub Environment |

The example workflows use version tags of GitHub-maintained actions for readability. Before publishing a production release, pin every third-party action to a reviewed full commit SHA and update it through a security-reviewed change.

## Caller examples

Runtime callers are shown in [`templates/`](../../templates/README.md). A publish workflow should be called only from a protected-branch event, never from arbitrary pull-request code. The caller must scope `id-token: write` to the publish/deploy job and configure its role trust policy narrowly.

Enable GitHub secret scanning/push protection and code scanning under organization policy; these controls are not replaced by the dependency-review workflow.

The ECR publishing workflow produces a digest and starts scan-on-push; it does not itself wait for scan results, sign the image, or approve deployment. Call `ecr-scan-gate.yml` before promotion and add organization-approved signature/provenance verification where required. The scan gate fails closed on scan errors or timeout. Publishing is restricted to a push on the repository's default branch as defense in depth; AWS OIDC trust policy must independently enforce the same or narrower scope.

The deploy workflow requires an explicit runner label because private EKS APIs are not reachable from GitHub-hosted runners. Configure a restricted, ephemeral AWS runner group with that label and network access only to required services. Its GitHub Environment protection rules are evaluated before the job starts. Configure an environment-scoped `AWS_DEPLOY_ROLE_ARN` secret in each target environment. Pass a chart path and environment values file from a reviewed caller workflow; use secrets only through scoped environment controls, not chart values committed to Git.
