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

module "subnet" {
  source              = "../../modules/subnet"
  public_vpc_id = module.vpc.vpc_id
  private_vpc_id = module.vpc.vpc_id
  cidr_public_subnet  = "10.0.1.0/24"
  cidr_private_subnet = "10.0.10.0/24"
  public_subnet_name  = "terraform_test_pub_stg"
  private_subnet_name = "terraform_test_prv_stg"
}

