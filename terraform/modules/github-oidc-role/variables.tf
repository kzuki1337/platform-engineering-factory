variable "name" {
  description = "IAM role name."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the existing GitHub Actions OIDC provider in this AWS account."
  type        = string
}

variable "github_subject" {
  description = "Exact GitHub OIDC subject, such as repo:acme/service:environment:prod."
  type        = string

  validation {
    condition     = length(var.github_subject) > 0 && !strcontains(var.github_subject, "*")
    error_message = "github_subject must be a non-empty exact subject and must not contain a wildcard."
  }
}

variable "managed_policy_arns" {
  description = "Explicit managed policy ARNs attached to this role. Keep the list least-privileged."
  type        = set(string)
  default     = []
}

variable "permissions_boundary_arn" {
  description = "Optional permissions boundary ARN mandated by the AWS organization."
  type        = string
  default     = null
  nullable    = true
}

variable "max_session_duration" {
  description = "Maximum assumed-role session duration in seconds."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
