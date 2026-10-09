output "repository_arn" {
  description = "ARN of the ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "Registry/repository URL, suitable for an image reference."
  value       = aws_ecr_repository.this.repository_url
}
