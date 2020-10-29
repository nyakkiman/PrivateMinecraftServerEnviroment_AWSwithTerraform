resource "aws_subnet" "public_subnet" {
  for_each          = var.public_subnet_numbers
  vpc_id            = var.public_subnet_vpc_id
  availability_zone = each.key
  cidr_block        = cidrsubnet(var.public_subnet_vpc_cidr, var.public_subnet_cidr_range, each.value)

  tags = {
    Name = "${var.public_subnet_name_prefix}${each.value}"
  }
}

# resource "aws_subnet" "private_subnet" {
#     for_each = var.private_subnet_numbers
#     vpc_id = var.private_subnet_vpc_id
#     availability_zone = each.key
#     cidr_block = cidrsubnet(var.private_subnet_vpc_cidr, var.private_subnet_cidr_range, length(var.public_subnet_numbers) + each.value) 
#     # cidr_block = var.private_subnet_vpc_cidr

#     tags = {
#         Name = "${var.private_subnet_name_prefix}${each.value}"
#     }
# }
