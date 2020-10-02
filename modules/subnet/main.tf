resource "aws_subnet" "public" {
    vpc_id = var.public_vpc_id
    cidr_block = var.cidr_public_subnet

    tags = {
        Name = var.public_subnet_name
    }
}

resource "aws_subnet" "private" {
    vpc_id = var.private_vpc_id
    cidr_block = var.cidr_private_subnet

    tags = {
        Name = var.private_subnet_name
    }
}