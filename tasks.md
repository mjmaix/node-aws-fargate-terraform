# TODO

1. Try EC2 instead of fargate
2. Auto build changes on terraform on push

# new infra

1. https://github.com/cloudposse/terraform-aws-codebuild/
2. https://github.com/cloudposse/terraform-aws-ecs-codepipeline/

   1. already have source build

3. add ecr repo

# ecs webapp

1. Should fix deploy3 build - missing envs
1. should not use NAT gateway, convert to public subnet
1. Add `codebuild_extra_policy_arns`
1. Should rename `ecs_private_subnet_ids` to `ecs_subnet_ids`
