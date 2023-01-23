provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "mja-demo-terraform-states"
    key    = "nodeawsfgtf/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}
