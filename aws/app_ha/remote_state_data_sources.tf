data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = var.aws_s3_bucket
        key = var.aws_s3_vpc_key
        region = var.aws_s3_region
        dynamodb_table = var.aws_dynamodb_lock_table_name
    }
}


data "terraform_remote_state" "mysql" {
    backend = "s3"
    config = {
        bucket = var.aws_s3_bucket
        key = var.aws_s3_mysql_key
        region = var.aws_s3_region
        dynamodb_table = var.aws_dynamodb_lock_table_name
    }
}

data "terraform_remote_state" "elastic" {
    backend = "s3"
    config = {
        bucket = var.aws_s3_bucket
        key = var.aws_s3_elastic_key
        region = var.aws_s3_region
        dynamodb_table = var.aws_dynamodb_lock_table_name
    }
}

data "terraform_remote_state" "rabbitmq" {
    backend = "s3"

    config = {
        bucket = var.aws_s3_bucket
        key = var.aws_s3_rabbitmq_key
        region = var.aws_s3_region
        dynamodb_table = var.aws_dynamodb_lock_table_name
    }
}
