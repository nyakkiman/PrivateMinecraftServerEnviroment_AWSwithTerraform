resource "aws_eip" "forNat" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.forNat.id
  subnet_id     = var.allocated_subnet_id

  tags = {
    Name = var.nat_gateway_name
  }
}
