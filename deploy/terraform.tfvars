default_region       = "ap-southeast-1"
default_az1          = "ap-southeast-1a"
default_az2          = "ap-southeast-1b"
ecs_launch_type      = "EC2"
ecs_assign_public_ip = true

docker_username     = "mjmaixdev"
github_full_repo_id = "mjmaix/node-aws-fargate-terraform"
app_name            = "mj-node-fg-aws"
environment         = "staging"


mongo_username                     = "admin-mjmaixdev"
mongo_host                         = "demo.iz3lksp.mongodb.net"
mongo_database_name                = "demo"
mongo_password_secret_arn          = "arn:aws:secretsmanager:ap-southeast-1:991300696177:secret:MongoPassword-7XU6iF"
codestar_connector_credentials_arn = "arn:aws:codestar-connections:ap-southeast-1:991300696177:connection/9b88de65-bc95-4208-b306-c5bf76efd7d0"
