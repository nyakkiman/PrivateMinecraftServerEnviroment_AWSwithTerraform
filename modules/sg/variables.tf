# security group settings
variable "sg_config" {
  type = object({
    name   = string
    vpc_id = string
    ingress_protocol_port = list(object({
      protocol = string
      port     = number
    }))
    ingress_cidr_blocks = list(string)
  })
}
