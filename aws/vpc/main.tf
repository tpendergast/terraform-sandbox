provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    key = "global/s3/vpc/terraform.tfstate"
  }
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet_ids" "default" {
    vpc_id = data.aws_vpc.default.id
}

