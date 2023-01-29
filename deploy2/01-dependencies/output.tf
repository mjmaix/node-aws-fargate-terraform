output "aws_ecr_repository_url" {
  value       = aws_ecr_repository.ecr_repo.repository_url
  description = "ECR Url for environment_variables.ECR_REPO_URL"
}

output "dockerhub_policy" {
  value       = aws_iam_policy.dockerhub_policy.arn
  description = "ARN for codebuild_extra_policy_arns"
}
