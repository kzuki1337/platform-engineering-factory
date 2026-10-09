# Private EKS foundation composition example

This composition example uses the upstream `terraform-aws-modules/eks/aws` module pinned to `20.37.1` and requires an existing organization-managed VPC with private subnets and suitable egress. It disables the public API endpoint and does not grant the Terraform creator implicit cluster-admin access.

Start by copying [`terraform.tfvars.example`](./terraform.tfvars.example) to `terraform.tfvars`. Replace the example cluster version, VPC/subnet IDs, region, and tags with values approved for your AWS account. The sample network IDs are deliberately invalid, so the example file cannot be applied as-is. Keep the populated `terraform.tfvars` local; do not commit account-specific configuration.

Before applying:

- Configure the approved remote backend and account/region controls.
- Supply private subnets in the required availability zones and verify their routes, DNS, endpoints, and outbound access for EKS/node operations.
- Define explicit EKS access entries/RBAC for platform operators, application delivery roles, and break-glass access.
- Review Kubernetes version support, node sizing, encryption, logging, add-ons, policies, quotas, and tagging with the platform team.
- Add a runner strategy separately; do not assume this application cluster is an appropriate privileged runner control plane.

This is a starting composition, not a production-ready cluster baseline. Review the upstream module's upgrade guide and all plan output before use.
