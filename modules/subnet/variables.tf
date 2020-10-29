### for public subnet setting
# vpc_id of VPC that contains this subnet
variable "public_subnet_vpc_id" {
  type        = string
  description = "required argument"
}

# new subnet cidr range
variable "public_subnet_cidr_range" {}

# vpc_cidr that contains and not conflicted this subnet's cidr 
variable "public_subnet_vpc_cidr" {
  type        = string
  description = "required argument"
}

# tag name that identify what this subnet is
variable "public_subnet_name_prefix" {
  type        = string
  description = "option argument but you'll not identify this subnet if you don't name"
}

# subnets az list
variable "public_subnet_numbers" {}

# ### for private subnet setting
# # vpc_id of VPC that contains this subnet
# variable "private_subnet_vpc_id" {
#     type = string
#     description = "required argument"
# }

# # new subnet cidr range
# variable "private_subnet_cidr_range" {}

# # vpc_cidr that contains and not conflicted this subnet's cidr 
# variable "private_subnet_vpc_cidr" {
#     type = string
#     description = "required argument"
# }

# # tag name that identify what this subnet is
# variable "private_subnet_name_prefix" {
#     type = string
#     description = "option argument but you'll not identify this subnet if you don't name"
# }

# # subnets az list
# variable "private_subnet_numbers" {}
