provider "aws" {
  profile = "default"
  version = "~> 3.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "aomaru-terraform-practice"
    region  = "us-east-1"
    key     = "enviroment/stg/terraform.tfstate"
    encrypt = true
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "terraform_test_stg"
}

