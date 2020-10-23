resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "security group for alb"
  vpc_id      = var.alb_sg_attached_vpc_id

  ingress {
    description = "allow http inbound traffic"
    from_port   = var.default_allow_ingress_port_from
    to_port     = var.default_allow_ingress_port_to
    protocol    = var.default_allow_ingress_protocol
    cidr_blocks = var.default_allow_ingress_cidr_blocks
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_use_subnets

  enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn

  port     = 80
  protocol = "HTTP"

  ################# temporary settings #################
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "Service cannot available"
    }
  }
}
