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

# variable "ami" {
#   type = string
#   description = "Ubuntu Server 18.04 in us-east-2"
#   default = "ami-0c55b159cbfafe1f0"
# }

variable "instance_ami" {
  type = string
  description = "Ubuntu Server 20.04 in us-east-1"
  default = "ami-06c8ff16263f3db59"
}

variable "instance_key_name" {
  type = string
  description = "Key name for testing in us-east-1"
  default = "tjp-terraform-us-east-1"
}

variable "instance_enable_monitoring" {
  type = bool
  description = "Boolean to determine whether to enable monitoring"
  default = true
}

variable "instance_instance_type" {
  type = string
  description = "Type of AWS machine image"
  default = "t2.large"
}

variable "aws_s3_bucket" {
  type = string
  default = "tjp-terraform-us-east-1"
}

variable "aws_s3_region" {
  type = string
  default = "us-east-1"
}

variable "aws_dynamodb_lock_table_name" {
  type = string
  default = "tjp-terraform-lock-table"
}

variable "aws_s3_elastic_key" {
  type = string
  default = "global/s3/elastic/terraform.tfstate"
}

variable "aws_s3_mysql_key" {
  type = string
  default = "global/s3/mysql/terraform.tfstate"
}

variable "aws_s3_rabbitmq_key" {
  type = string
  default = "global/s3/rabbitmq/terraform.tfstate"
}

variable "aws_s3_vpc_key" {
  type = string
  default = "global/s3/vpc/terraform.tfstate"
}
