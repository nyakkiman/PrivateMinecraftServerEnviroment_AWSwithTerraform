provider "aws" {
  profile = "default"
  version = "~> 3.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "aomaru-terraform-practice"
    region  = "us-east-1"
    key     = "enviroment/prd/terraform.tfstate"
    encrypt = true
  }
}

module "vpc" {
  source       = "../../modules/vpc"
  vpc_cidr     = "10.1.0.0/16"
  vpc_name_tag = "terraform_test_prd"
}

module "subnet" {
  source = "../../modules/subnet"
  # public subnet
  public_subnet_vpc_id      = module.vpc.vpc_id
  public_subnet_vpc_cidr    = module.vpc.vpc_cidr_block
  public_subnet_cidr_range  = 8
  public_subnet_name_prefix = "terraform_test_public_product_"
  # Declare as many public subnets as you want
  public_subnet_numbers = {
    "us-east-1a" = 0
  }

  # private subnet
  private_subnet_vpc_id      = module.vpc.vpc_id
  private_subnet_vpc_cidr    = module.vpc.vpc_cidr_block
  private_subnet_cidr_range  = 8
  private_subnet_name_prefix = "terraform_test_private_product_"
  # Declare as many private subnets as you want
  private_subnet_numbers = {
    "us-east-1a" = 0
  }
}
