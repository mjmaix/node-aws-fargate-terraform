

resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.namespace}-${var.stage}-${var.name}"
}

resource "aws_iam_policy" "dockerhub_policy" {
  name = "${var.namespace}-${var.stage}-${var.name}-codebuild-dockerhub-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ]
        Effect   = "Allow"
        Resource = var.dockerhub_access_token_secret_arn
      },
      {
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
