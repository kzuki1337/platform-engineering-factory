# Sharing the CI/CD framework with application repositories

## Goal

Maintain one platform-owned repository for reusable CI/CD workflows, Terraform modules, and starter templates. Application teams consume released versions rather than copying framework implementation into every repository.

The contents under `cicd/` are currently a local starter. Other repositories cannot consume them until the framework is published to an organization GitHub repository and access is configured.

## How consumers use each component

| Component | Distribution | Consumer behavior |
|---|---|---|
| Reusable GitHub Actions workflows | Versioned workflow files in the platform repository | Call a workflow at a pinned release ref |
| Terraform modules | Private Terraform module registry, or versioned Git source | Reference a pinned module version/tag in Terraform |
| Application starters | GitHub template repositories or an approved scaffolding tool | Generate a new app repository, then own its application code |
| Helm chart | OCI chart registry or versioned chart distribution | Pin a chart version; keep environment-specific non-secret values with the app |
| Documentation and policies | Platform repository | Follow current supported release and adoption guidance |

## Reusable workflow example

Replace the organization, repository, and release with the actual platform repository and a published version:

```yaml
jobs:
  ci:
    uses: your-org/cicd-platform/.github/workflows/python-ci.yml@v1.0.0
```

Configure private reusable-workflow access if the platform repository is not public. Production consumers should use reviewed immutable release refs according to organization policy. Pin third-party actions inside released workflows to reviewed full commit SHAs.

## Terraform module example

Prefer publishing modules to the organization's private Terraform registry. If Git sources are used, pin them to a release tag:

```hcl
module "ecr" {
  source = "git::https://github.com/your-org/cicd-platform.git//terraform/modules/ecr-repository?ref=v1.0.0"

  repository_name = "my-service"
}
```

The platform team should create shared ECR repositories and narrowly scoped IAM roles through platform-owned infrastructure. Application workflows use their assigned roles to publish images; deployment workflows promote the resulting image digest.

## Starter and chart distribution

Publish starter projects as GitHub template repositories or generate them through an approved scaffolding mechanism. A starter is a bootstrap: once created, the application team owns the service source, tests, Dockerfile, and environment values.

Publish Helm charts with versioned releases, preferably to an OCI-compatible chart registry. Keep secrets out of values files. Application teams should pin chart versions and image digests and configure environment-specific promotion and approvals.

## Terraform variables example

The EKS `terraform.tfvars.example` is a guide for a cluster-owning platform or infrastructure repository. It is not required in every application repository. Copy it to a local `terraform.tfvars`, replace all placeholders with approved AWS values, and do not commit account-specific local values.

## Platform release and governance

1. Protect the platform repository with branch rules, code ownership, and reviewed changes.
2. Validate workflow contracts, modules, templates, and charts before release.
3. Publish semantic versions: patch/minor releases for compatible changes and a new major version for breaking changes.
4. Never move or overwrite published version tags.
5. Document release notes, migration guidance, support windows, and deprecations.
6. Notify consumers or generate upgrade pull requests so teams can adopt changes deliberately.
7. Track adoption by framework version and provide a supported migration path.

## Next steps

- Decide the organization repository name, visibility, maintainers, and release permissions.
- Configure cross-repository access for reusable workflows.
- Choose a Terraform module publishing method and Helm OCI registry.
- Convert example workflow references from `YOUR-ORG/platform-cicd` to the actual repository at release time.
- Publish starter repositories or select a scaffolding tool.
- Establish release tagging, changelog, compatibility, and deprecation policy.
