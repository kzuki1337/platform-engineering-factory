# GitHub OIDC role

Creates an IAM role trusted by one exact GitHub Actions OIDC `sub` and audience. The GitHub OIDC provider must already exist in the account. The module intentionally does not create permissions: callers must supply reviewed managed policy ARNs and should use separate roles for publishing, Terraform, and each deployment environment.

Example subjects:

- Branch-scoped: `repo:acme/service:ref:refs/heads/main`
- Environment-scoped: `repo:acme/service:environment:prod`

For production, prefer a protected GitHub Environment subject, require reviewer controls in that environment, and ensure the role policy is resource-scoped. An exact OIDC subject does not by itself restrict what the assumed role can do.
