

resource "aws_codepipeline" "node_express_ecs_codepipeline" {
  name       = "node_express_ecs_codepipeline"
  role_arn   = aws_iam_role.node_express_ecs_codepipeline_role.arn
  depends_on = [aws_ecs_service.staging]


  artifact_store {
    location = aws_s3_bucket.node_app.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        BranchName       = "master"
        ConnectionArn    = var.codestar_connector_credentials_arn
        FullRepositoryId = var.github_full_repo_id
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.node_aws_fargate_app.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = aws_ecs_cluster.staging.name
        ServiceName = aws_ecs_service.staging.name
      }
    }
  }

}

