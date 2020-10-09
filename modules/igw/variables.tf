# attached VPC's id
variable "attached_vpc_id" {
    type = string
    description = "required argument"
}

# tag name
variable "internet_gateway_name" {
    type = string
    description = "internet gateway name"
}
