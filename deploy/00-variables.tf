variable "codestar_connector_credentials_arn" {}

variable "github_full_repo_id" {}

variable "app_name" {}

variable "environment" {}

variable "default_region" {}

variable "default_az1" {}

variable "default_az2" {}

variable "ecs_launch_type" {
  type        = string
  description = "EC2 or FARGATE"
  default     = "FARGATE"
}

var "ecs_assign_public_ip" {
  type        = bool
  description = "Applicable only for FARGATE type"
  value       = true
}

variable "docker_username" {}

variable "mongo_username" {}

variable "mongo_host" {}

variable "mongo_database_name" {}

variable "mongo_password_secret_arn" {}

