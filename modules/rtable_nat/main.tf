resource "aws_route_table" "egress" {
  vpc_id = var.vpcid

  tags = {
    Name = "routetabe_to_nat"
  }
}

resource "aws_route" "to_nat" {
  route_table_id = aws_route_table.egress.id
  nat_gateway_id = var.targetid_to_nat

  destination_cidr_block = var.routing_dest_cidr_from_to_nat
}

resource "aws_route_table_association" "to_nat" {
  route_table_id = aws_route_table.egress.id
  subnet_id      = var.association_target_id
}
