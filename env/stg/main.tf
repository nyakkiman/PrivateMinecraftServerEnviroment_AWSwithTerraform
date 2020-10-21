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

module "internet_gateway" {
  source = "../../modules/igw"

  attached_vpc_id       = module.vpc.vpc_id
  internet_gateway_name = "terraform_test_stg_igw"
}

module "subnet" {
  source = "../../modules/subnet"

  # public subnet
  public_subnet_vpc_id      = module.vpc.vpc_id
  public_subnet_vpc_cidr    = module.vpc.vpc_cidr_block
  public_subnet_cidr_range  = 8
  public_subnet_name_prefix = "terraform_test_public_staging_"
  # Specify AZ and declare as many public subnets as you want
  public_subnet_numbers = {
    "us-east-1a" = 0
    "us-east-1c" = 1
  }

  # private subnet
  private_subnet_vpc_id      = module.vpc.vpc_id
  private_subnet_vpc_cidr    = module.vpc.vpc_cidr_block
  private_subnet_cidr_range  = 8
  private_subnet_name_prefix = "terraform_test_private_staging_"
  # Specify AZ and declare as many private subnets as you want
  private_subnet_numbers = {
    "us-east-1a" = 0
    "us-east-1c" = 1
  }
}

module "nat_gateway" {
  source   = "../../modules/nat"
  for_each = module.subnet.public_subnet_numbers

  allocated_subnet_id = module.subnet.public_subnet_ids[each.value]
  nat_gateway_name    = "terraform_test_staging_nat"
}

#### routetables
# internet gateway
module "route_table_igw" {
  source = "../../modules/rtable_igw"

  # routetable subnet to igw
  vpcid                         = module.vpc.vpc_id
  targetid_to_igw               = module.internet_gateway.igw_id
  routing_dest_cidr_from_to_igw = "0.0.0.0/0"
}

resource "aws_route_table_association" "to_igw" {
  # routetable subnet to igw
  for_each = module.subnet.public_subnet_numbers

  subnet_id      = module.subnet.public_subnet_ids[each.value]
  route_table_id = module.route_table_igw.routetable_id_egress
}

# nat gateway
module "route_table_nat" {
  source = "../../modules/rtable_nat"

  # routetable subnet to nat
  for_each = module.subnet.public_subnet_numbers

  vpcid                         = module.vpc.vpc_id
  targetid_to_nat               = values(module.nat_gateway)[each.value].nat_ids
  routing_dest_cidr_from_to_nat = "0.0.0.0/0"
  association_target_id         = module.subnet.private_subnet_ids[each.value]
}

