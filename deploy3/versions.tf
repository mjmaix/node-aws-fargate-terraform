terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.34"
    }
  }

  backend "s3" {
    bucket = "mja-demo-terraform-states"
    key    = "nodeawsfgtf3-main/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
