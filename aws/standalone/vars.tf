variable "server_port" {
  description = "HTTP listen port for test web server"
  type        = number
  default     = 8081
}

variable "https_port" {
  description = "HTTPS listen port for standalone morpheus server"
  type        = number
  default     = 443
}

variable "ssh_port" {
  description = "SSH listen port"
  type        = number
  default     = 22
}

variable morpheus_package {
  type = string
  default = "morpheus-appliance_5.2.3-2_amd64.deb"
}

variable input_cidr_blocks {
  type = list(string)
  default = ["76.235.96.74/32","165.225.0.69/32"]
}