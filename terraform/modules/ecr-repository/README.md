# ECR repository

Creates an encrypted ECR repository with immutable image tags, scan-on-push, and lifecycle retention. The module does not create publisher or puller IAM permissions; define narrowly scoped policies separately. Enable enhanced scanning, cross-region/account replication, and organization-required policies at the registry/account level where appropriate.

Lifecycle rules are examples. Validate retention against rollback, audit, and regulatory requirements before adoption. The tagged-image rule uses a wildcard tag pattern and retains the newest configured count.
