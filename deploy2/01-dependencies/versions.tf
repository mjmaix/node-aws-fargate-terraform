terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket = "mja-demo-terraform-states"
    key    = "nodeawsfgtf-main-deps/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
