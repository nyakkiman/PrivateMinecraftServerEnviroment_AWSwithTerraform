resource "aws_route_table" "egress" {
  vpc_id = var.vpcid

  tags = {
    Name = "routetabe_to_igw"
  }
}

resource "aws_route" "to_igw" {
  route_table_id = aws_route_table.egress.id
  gateway_id     = var.targetid_to_igw

  destination_cidr_block = var.routing_dest_cidr_from_to_igw
}
