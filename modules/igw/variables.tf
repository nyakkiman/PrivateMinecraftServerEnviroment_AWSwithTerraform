# attached VPC's id
variable "attached_vpc_id" {
  type        = string
  description = "required argument"
}

# tag name
variable "internet_gateway_name_tag" {
  type        = string
  description = "internet gateway name"
}
