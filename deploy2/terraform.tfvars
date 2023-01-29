region = "ap-southeast-1"

availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

namespace = "eg"

stage = "test"

name = "node-aws-ecs-tf3"

vpc_cidr_block = "172.16.0.0/16"

ecs_launch_type = "EC2"
# ecs_launch_type = "FARGATE"

network_mode = "awsvpc"

ignore_changes_task_definition = true

assign_public_ip = false

propagate_tags = "TASK_DEFINITION"

deployment_minimum_healthy_percent = 100

deployment_maximum_percent = 200

deployment_controller_type = "ECS"

desired_count = 1

task_memory = 512

task_cpu = 256

container_name = "nodetfaws"

container_image = "mja/nodetfaws"

container_memory = 256

container_memory_reservation = 128

container_cpu = 256

container_essential = true

container_readonly_root_filesystem = false

# TODO: convert to secrets or parameter store
container_environment = [
  {
    name  = "NODE_ENV"
    value = "production"
  },
  {
    name  = "JWT_SECRET"
    value = "superscretwhichshouldnotbehere"
  },
  {
    name  = "MONGO_USERNAME"
    value = "admin-mjmaixdev"
  },
  {
    name  = "MONGO_HOST"
    value = "demo.iz3lksp.mongodb.net"
  },
  {
    name  = "MONGO_DB_NAME"
    value = "demo"
  },
]

# TODO: convert to secrets or parameter store
container_secrets = [
  {
    name      = "MONGO_PASSWORD"
    valueFrom = "arn:aws:secretsmanager:ap-southeast-1:991300696177:secret:MongoPassword-7XU6iF"
  }
]

container_port_mappings = [
  {
    containerPort = 80
    hostPort      = 80
    protocol      = "tcp"
  },
  {
    containerPort = 443
    hostPort      = 443
    protocol      = "udp"
  }
]

codestar_connection_arn = "arn:aws:codestar-connections:ap-southeast-1:991300696177:connection/9b88de65-bc95-4208-b306-c5bf76efd7d0"

repo_owner = "mjmaix"

repo_name = "node-aws-fargate-terraform"

branch = "master"

build_image = "aws/codebuild/standard:6.0"

build_compute_type = "BUILD_GENERAL1_SMALL"

build_timeout = 60

poll_source_changes = false

privileged_mode = true

image_repo_name = "node-aws-fargate-terraform"

image_tag = "latest"

webhook_enabled = false

s3_bucket_force_destroy = true

environment_variables = [
  {
    name  = "TIME_ZONE"
    value = "GMT"
    type  = "PLAINTEXT"

  },
  {
    name  = "DOCKER_USERNAME"
    value = "mjmaixdev"
    type  = "PLAINTEXT"
  },
]

###########################################
# Start - Get from ./01-dependencies output
###########################################
codebuild_extra_policy_arns = ["arn:aws:iam::991300696177:policy/secrets-dockerhubaccesstoken-policy", "arn:aws:iam::aws:policy/AdministratorAccess"]

dockerhub_access_token_secret_arn = "arn:aws:iam::991300696177:policy/eg-test-node-aws-ecs-tf3-codebuild-dockerhub-policy"
###########################################
# End - Get from ./01-dependencies output
###########################################
