# allocated VPC's ID
variable "vpcid" {
  type        = string
  description = "required argument"
}

# target gateway
variable "targetid_to_igw" {
  type        = string
  description = "routetable's target gateway id"
}

variable "routing_dest_cidr_from_to_igw" {
  type        = string
  description = "destination cidr"
}
