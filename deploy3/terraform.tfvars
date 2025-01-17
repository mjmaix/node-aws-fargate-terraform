region = "ap-southeast-1"

availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

namespace = "mja1"

stage = "test"

name = "ecs-web-app"

vpc_cidr_block = "172.16.0.0/16"

assign_public_ip = false

# container_image = "mjmaix/tfawsdeploy3"

container_cpu = 256

container_memory = 512

container_memory_reservation = 128

container_port = 80

container_port_mappings = [
  {
    containerPort = 80
    hostPort      = 80
    protocol      = "tcp"
  }
]

desired_count = 1

launch_type = "FARGATE"

alb_target_group_alarms_enabled = true

alb_target_group_alarms_3xx_threshold = 25

alb_target_group_alarms_4xx_threshold = 25

alb_target_group_alarms_5xx_threshold = 25

alb_target_group_alarms_response_time_threshold = 0.5

alb_target_group_alarms_period = 300

alb_target_group_alarms_evaluation_periods = 1

alb_ingress_healthcheck_path = "/ping"

alb_ingress_listener_unauthenticated_priority = 1000

alb_ingress_unauthenticated_paths = ["/"]

aws_logs_region = "ap-southeast-1"

log_driver = "awslogs"

ecs_alarms_enabled = true

ecs_alarms_cpu_utilization_high_threshold = 80

ecs_alarms_cpu_utilization_high_evaluation_periods = 1

ecs_alarms_cpu_utilization_high_period = 300

ecs_alarms_cpu_utilization_low_threshold = 20

ecs_alarms_cpu_utilization_low_evaluation_periods = 1

ecs_alarms_cpu_utilization_low_period = 300

ecs_alarms_memory_utilization_high_threshold = 80

ecs_alarms_memory_utilization_high_evaluation_periods = 1

ecs_alarms_memory_utilization_high_period = 300

ecs_alarms_memory_utilization_low_threshold = 20

ecs_alarms_memory_utilization_low_evaluation_periods = 1

ecs_alarms_memory_utilization_low_period = 300

autoscaling_enabled = true

autoscaling_dimension = "memory"

autoscaling_min_capacity = 1

autoscaling_max_capacity = 2

autoscaling_scale_up_adjustment = 1

autoscaling_scale_up_cooldown = 60

autoscaling_scale_down_adjustment = -1

autoscaling_scale_down_cooldown = 300

poll_source_changes = false

webhook_enabled = false

webhook_target_action = "Source"

webhook_filter_json_path = "$.ref"

webhook_filter_match_equals = "refs/heads/{Branch}"

authentication_type = ""

codepipeline_enabled = true

codepipeline_s3_bucket_force_destroy = true

# moved to secrets.tfvars
# codepipeline_github_oauth_token = "test"

codepipeline_github_webhook_events = ["push"]

codepipeline_repo_owner = "mjmaix"

codepipeline_repo_name = "node-aws-fargate-terraform"

codepipeline_branch = "master"

codepipeline_badge_enabled = false

codepipeline_build_image = "aws/codebuild/docker:17.09.0"

codepipeline_build_timeout = 20

use_ecr_image = true

build_environment_variables = [
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

container_environment = []
