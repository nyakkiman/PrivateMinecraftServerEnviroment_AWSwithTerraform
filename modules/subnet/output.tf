output "public_subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "public_subnet_numbers" {
  value = var.public_subnet_numbers
}

# output "private_subnet_ids" {
#   value = values(aws_subnet.private_subnet)[*].id
# }

# output "private_subnet_numbers" {
#   value = var.private_subnet_numbers
# }
