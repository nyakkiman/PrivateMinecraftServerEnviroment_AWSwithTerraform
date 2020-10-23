variable "alb_sg_name" {
  type = string
}

variable "alb_sg_attached_vpc_id" {
  type = string
}

variable "alb_use_subnets" {
  type = list(string)
}

# security group settings
variable "default_allow_ingress_port_from" {}
variable "default_allow_ingress_port_to" {}
variable "default_allow_ingress_protocol" {
  type = string
}
variable "default_allow_ingress_cidr_blocks" {
  type = list(string)
}
