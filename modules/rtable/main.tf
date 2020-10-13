resource "aws_route_table" "to_igw" {
  vpc_id = var.vpcid_subnet_to_igw

  tags = {
    Name = "routetabe_to_igw"
  }
}

resource "aws_route" "to_igw" {
  route_table_id = aws_route_table.to_igw.id
  gateway_id     = var.gatewayid_subnet_to_igw

  for_each               = toset(var.routing_dest_cidr_from_subnet_to_igw)
  destination_cidr_block = each.value
}
