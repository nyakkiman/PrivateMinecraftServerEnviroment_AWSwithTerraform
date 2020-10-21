# allocated VPC's ID
variable "vpcid" {
  type        = string
  description = "required argument"
}

# target nat
variable "targetid_to_nat" {
  description = "routetable's target nat id"
}

variable "routing_dest_cidr_from_to_nat" {
  type        = string
  description = "destination cidr"
}

variable "association_target_id" {
  type        = string
  description = "association target id"
}
