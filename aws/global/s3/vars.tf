variable "aws_provider_region" {
  type = string
  default = "us-east-1"
}

variable "aws_s3_bucket_name" {
  type = string
  default = "tjp-terraform-us-east-1"
}

variable "aws_dynamodb_table_name" {
  type = string
  default = "tjp-terraform-lock-table"
}




