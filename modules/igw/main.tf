resource "aws_internet_gateway" "igw" {
  vpc_id = var.attached_vpc_id

  tags = {
    Name = var.internet_gateway_name_tag
  }
}
