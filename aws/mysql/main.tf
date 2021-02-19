provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    key = "global/s3/mysql/terraform.tfstate"
  }
}
