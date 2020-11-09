provider "aws" {
  profile = "default"
  version = "~> 3.0"
  region  = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket  = "aomaru-terraform-practice"
    region  = "us-east-1"
    key     = "enviroment/minecraft/prd/terraform.tfstate"
    encrypt = true
  }
}

#################################################
# Network
#################################################
module "vpc" {
  source       = "../../modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  vpc_name_tag = "minecraft_test"
}

module "internet_gateway" {
  source = "../../modules/igw"

  attached_vpc_id           = module.vpc.vpc_id
  internet_gateway_name_tag = "minecraft_env_test_igw"
}

module "subnet" {
  source = "../../modules/subnet"

  # public subnet
  public_subnet_vpc_id      = module.vpc.vpc_id
  public_subnet_vpc_cidr    = module.vpc.vpc_cidr_block
  public_subnet_cidr_range  = 8
  public_subnet_name_prefix = "minecraft_test_public_prd_"
  # Specify AZ and declare as many public subnets as you want
  public_subnet_numbers = {
    "ap-south-1a" = 0
  }
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

#################################################
# Application
#################################################
#### EC2
# security group
module "ec2_sg" {
  source = "../../modules/sg"

  sg_config = {
    name                  = "ec2-minecraft-sg"
    vpc_id                = module.vpc.vpc_id
    ingress_protocol_port = [{ protocol = "icmp", port = -1 }, { protocol = "tcp", port = 22 }, { protocol = "tcp", port = 25565 }]
    ingress_cidr_blocks   = ["0.0.0.0/0"]
  }
}

# ami
data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# instance
resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ssm_parameter.amazon_linux_2.value
  instance_type          = "t3.small"
  vpc_security_group_ids = [module.ec2_sg.security_group_id]
  key_name               = aws_key_pair.ec2_keypair.id
  subnet_id              = module.subnet.public_subnet_ids[0]

  root_block_device {
    volume_type = "gp2"
    volume_size = 16
  }

  tags = {
    Name = "minecraft test"
  }
}

# key pair
resource "aws_key_pair" "ec2_keypair" {
  key_name = "minecraft_test_key"

  # change as appropriate
  public_key = file("./id_rsa.pub")
}

# elastic ip
resource "aws_eip" "ec2_eip" {
  instance   = aws_instance.ec2_instance.id
  vpc        = true
  depends_on = [module.internet_gateway]
}
