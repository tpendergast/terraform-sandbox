provider "aws" {
  region = var.aws_provider_region
}

resource "aws_s3_bucket" "terraform-s3-state" {
  bucket = var.aws_s3_bucket_name

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = var.aws_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

