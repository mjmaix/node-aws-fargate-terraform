provider "aws" {
  region = var.region
}

module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.0.0"
  enabled                 = true
  ipv4_primary_cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source               = "cloudposse/dynamic-subnets/aws"
  version              = "2.1.0"
  enabled              = true
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = true
  nat_instance_enabled = false

  context = module.this.context
}

resource "aws_ecs_cluster" "default" {
  name = module.this.id
  tags = module.this.tags
}

module "container_definition" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.58.1"
  container_name               = var.container_name
  container_image              = var.container_image
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_cpu                = var.container_cpu
  essential                    = var.container_essential
  readonly_root_filesystem     = var.container_readonly_root_filesystem
  environment                  = var.container_environment
  secrets                      = var.container_secrets
  port_mappings                = var.container_port_mappings
}

module "ecs_alb_service_task" {
  source                             = "cloudposse/ecs-alb-service-task/aws"
  version                            = "0.66.4"
  enabled                            = true
  alb_security_group                 = module.vpc.vpc_default_security_group_id
  container_definition_json          = module.container_definition.json_map_encoded_list
  ecs_cluster_arn                    = aws_ecs_cluster.default.arn
  launch_type                        = var.ecs_launch_type
  vpc_id                             = module.vpc.vpc_id
  security_group_ids                 = [module.vpc.vpc_default_security_group_id]
  subnet_ids                         = module.subnets.public_subnet_ids
  tags                               = module.this.tags
  ignore_changes_task_definition     = var.ignore_changes_task_definition
  network_mode                       = var.network_mode
  assign_public_ip                   = var.assign_public_ip
  propagate_tags                     = var.propagate_tags
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_controller_type         = var.deployment_controller_type
  desired_count                      = var.desired_count
  task_memory                        = var.task_memory
  task_cpu                           = var.task_cpu

  context = module.this.context
}

module "ecs_codepipeline" {
  source                  = "cloudposse/ecs-codepipeline/aws"
  version                 = "0.31.0"
  enabled                 = true
  region                  = var.region
  github_oauth_token      = var.github_oauth_token
  codestar_connection_arn = var.codestar_connection_arn
  repo_owner              = var.repo_owner
  repo_name               = var.repo_name
  branch                  = var.branch
  build_image             = var.build_image
  build_compute_type      = var.build_compute_type
  build_timeout           = var.build_timeout
  poll_source_changes     = var.poll_source_changes
  privileged_mode         = var.privileged_mode
  image_repo_name         = var.image_repo_name
  image_tag               = var.image_tag
  webhook_enabled         = var.webhook_enabled
  s3_bucket_force_destroy = var.s3_bucket_force_destroy
  environment_variables = concat(var.environment_variables, [
    {
      name  = "CONTAINER_NAME"
      value = var.container_name
      type  = "PLAINTEXT"
    },
    {
      name  = "IMAGE_NAME"
      value = var.container_image
      type  = "PLAINTEXT"
    },
  ])
  ecs_cluster_name            = aws_ecs_cluster.default.name
  service_name                = module.ecs_alb_service_task.service_name
  codebuild_extra_policy_arns = var.codebuild_extra_policy_arns

  context = module.this.context
}
