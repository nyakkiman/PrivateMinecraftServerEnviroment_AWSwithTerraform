resource "aws_security_group" "base_sg" {
  name   = var.sg_config.name
  vpc_id = var.sg_config.vpc_id

  dynamic "ingress" {
    for_each = var.sg_config.ingress_protocol_port

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = var.sg_config.ingress_cidr_blocks
    }
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
