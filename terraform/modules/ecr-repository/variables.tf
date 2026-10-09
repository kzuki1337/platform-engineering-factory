variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "kms_key_arn" {
  description = "Optional customer-managed KMS key ARN. ECR AES256 encryption is used when null."
  type        = string
  default     = null
  nullable    = true
}

variable "retain_tagged_images" {
  description = "Number of most recently pushed tagged images to retain."
  type        = number
  default     = 50

  validation {
    condition     = var.retain_tagged_images >= 1
    error_message = "retain_tagged_images must be at least 1."
  }
}

variable "expire_untagged_after_days" {
  description = "Age in days after which untagged images can be expired."
  type        = number
  default     = 14

  validation {
    condition     = var.expire_untagged_after_days >= 1
    error_message = "expire_untagged_after_days must be at least 1."
  }
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
