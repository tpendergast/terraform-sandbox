output "default_vpc_id" {
    value = data.aws_vpc.default.id
}

output "current_vpc_id" {
    # This is the using the default vpc for testing
    value = data.aws_vpc.default.id
}

output "public_subnet_ids" {
    value = data.aws_subnet_ids.default
}

