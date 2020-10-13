# allocated VPC's ID
variable "vpcid_subnet_to_igw" {
  type        = string
  description = "required argument"
}

variable "gatewayid_subnet_to_igw" {
  type        = string
  description = "routetable's target gateway id"
}

variable "routing_dest_cidr_from_subnet_to_igw" {
  type        = list(string)
  description = "destination cidr"
}
