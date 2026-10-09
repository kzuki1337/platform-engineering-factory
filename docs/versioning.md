# Versioning and contribution model

## Release policy

- Use semantic versioning for workflows/modules: patch for backward-compatible fixes, minor for additive compatible capabilities, major for breaking input/output or policy changes.
- Publish protected release tags (for example `v1.2.0`) and maintain a major alias only when the organization can safely move it. Production consumers should pin an immutable version or commit SHA.
- Release workflow and Terraform module changes with changelogs, migration notes, owners, supported versions, and a deprecation date for removed behavior.
- Do not force-move version tags. Protect release creation and require reviewed changes from designated owners.
- Keep reusable workflow inputs explicit, typed, and documented. Validate required inputs and fail clearly; do not silently weaken a gate when configuration is absent.

## Change process

1. Open a feature branch and pull request with tests and documentation.
2. Run formatting, workflow validation, Terraform validation, and applicable security checks.
3. Require platform CODEOWNERS review for reusable workflow, IAM, runner, Terraform, and policy changes.
4. Test changes in an isolated sandbox and a consumer fixture before tagging a release.
5. Publish a release note and notify consuming teams; automate upgrade PRs where possible.

## Consumer example

Applications should call the centrally published reusable workflow at an approved immutable ref:

```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]
permissions:
  contents: read
jobs:
  ci:
    uses: YOUR-ORG/platform-cicd/.github/workflows/node-ci.yml@v1.0.0
    with:
      node-version: "22"
      working-directory: .
```

Replace organization/repository and pin the release ref according to organization policy. Reusable workflows must be accessible to the caller repository. Add only required `permissions` and environment configuration in the caller.

## Compatibility

- Maintain a consumer fixture for each supported runtime.
- Test workflow interfaces and Terraform module examples on every change.
- Announce breaking changes early, publish migration guidance, and support an agreed overlap period.
- Track consumers still using deprecated releases and contact owners before removal.
