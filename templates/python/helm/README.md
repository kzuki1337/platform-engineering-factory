# Helm chart and environment values

Copy the maintained [`helm/application`](../../../helm/application/) chart into this directory before using the example release workflow. Create the `values/` files below for the service and commit them with reviewed, non-secret configuration. Configure repository or organization variables for `AWS_REGION`, `ECR_REPOSITORY`, and each `*_EKS_CLUSTER_NAME`. Configure repository secrets for `AWS_PUBLISH_ROLE_ARN` and read-only `AWS_SCAN_ROLE_ARN`; configure each matching GitHub Environment (`dev`, `qa`, `uat`, `stg`, `prod`) with a scoped `AWS_DEPLOY_ROLE_ARN` secret and protection rules. Production should require designated reviewers.

The release workflow passes one image digest from ECR through every stage; it does not rebuild between environments. Add integration/smoke-test jobs and policy checks between stages based on service needs.
