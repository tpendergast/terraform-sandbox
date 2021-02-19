output "server_port" {
  description = "HTTP port to listen on"
  value       = var.server_port
}

output "https_port" {
  description = "HTTPS port for morpheus server"
  value       = var.https_port
}

output "public_ip_0" {
    value = aws_instance.example[0].public_ip
}

output "public_dns_0" {
    value = aws_instance.example[0].public_dns
}

output "current_vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.current_vpc_id
}

output "default_vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.default_vpc_id
}

output "instance_ami" {
  value = var.instance_ami
}

output "instance_type" {
  value = var.instance_instance_type
}

# output "public_ip_1" {
#     value = aws_instance.example[1].public_ip
# }

# output "public_dns_1" {
#     value = aws_instance.example[1].public_dns
# }

# output "alb_dns_name" {
#   value = aws_lb.example.dns_name
# }