# AWS Fargate Node App

A reference project to deploy a Node Express app onto Amazon ECS on AWS Fargate with Terraform, inspired by [this](https://dev.to/txheo/a-guide-to-provisioning-aws-ecs-fargate-using-terraform-1joo) tutorial documentation

A microservice which creates, and authenticates users from a MongoDB database

![AWS Architecture](img/aws-node-ecs2.JPG)

## Pre-requisite

- Make sure you have installed [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli), [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html#cliv2-mac-prereq), and configured a `default` AWS CLI profile (see doc [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-profiles))

```bash
terraform -help # prints Terraform options
which aws # prints /usr/local/bin/aws
aws --version # prints aws-cli/2.0.36 Python/3.7.4 Darwin/18.7.0 botocore/2.0.0
aws configure # configure your AWS CLI profile
```

- You have created a database on [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) and have obtained a database connection string

## Configuration

- Create an [S3 bucket](https://www.terraform.io/docs/language/settings/backends/s3.html) to store Terraform state. Populate bucket name in `01-main.tf`

- Create a secret on [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) named `DockerHubAccessToken` with key `DOCKER_HUB_ACCESS_TOKEN`, and your [Docker access token](https://docs.docker.com/docker-hub/access-tokens/) as value

- Create a secret on [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) named `MongoPassword` with key `MONGO_PASSWORD`, and your MongoDB password as value

- Setup [CodePipeline CodeStarConnections](https://docs.aws.amazon.com/codepipeline/latest/userguide/update-github-action-connections.html) with read rights for the repo and save the ARN to `terraform.tfvars`

- Populate `terraform.tfvars`:

```bash
default_region                     = "ap-southeast-1"
default_az1                        = "ap-southeast-1a"
default_az2                        = "ap-southeast-1b"
docker_username                    = "mjmaixdev"
github_full_repo_id                = "mjmaix/node-aws-fargate-terraform"
app_name                           = "mj-node-fg-aws"
environment                        = "staging"
mongo_username                     = "admin-mjmaixdev"
mongo_host                         = "iz3lksp.mongodb.net"
mongo_database_name                = "demo"
mongo_password_secret_arn          = <MongoPassword Secret ARN>
codestar_connector_credentials_arn = <Codestar Connector Credenetials ARN>

```

## Deploy

```bash
cd deploy # change to deploy directory
terraform init # initialises Terraform
terraform apply # deploys AWS stack. See output for AWS loadbalancer DNS name
terraform destroy # destroys AWS stack
```

## Usage

- Create a user by making `POST` request to `/api/users` with the following JSON body:

```json
{
  "email": "jon@doe.com",
  "password": "password",
  "name": "jondoe"
}
```

- See Postman collection [here](https://www.getpostman.com/collections/471ace71d8c991681342)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

If you find this project helpful, please give a :star: or even better buy me a coffee :coffee: :point_down: because I'm a caffeine addict :sweat_smile:

<a href="https://www.buymeacoffee.com/matlau" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## License

[MIT](https://choosealicense.com/licenses/mit/)
