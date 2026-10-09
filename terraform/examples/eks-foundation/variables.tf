variable "aws_region" {
  description = "AWS region for the EKS cluster."
  type        = string
}

variable "cluster_name" {
  description = "Name for the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version supported by the selected EKS module release."
  type        = string
}

variable "vpc_id" {
  description = "ID of the organization-managed VPC."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for the cluster control plane and worker nodes."
  type        = list(string)
}

variable "tags" {
  description = "Required organization and cost-allocation tags."
  type        = map(string)
  default     = {}
}
