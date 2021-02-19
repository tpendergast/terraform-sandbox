provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    key = "global/s3/app_ha/terraform.tfstate"
  }
}




# data "aws_vpc" "default" {
#     default = true
# }

# data "aws_subnet_ids" "default" {
#     vpc_id = data.aws_vpc.default.id
# }

resource "aws_security_group" "ha_instance" {
    name = "terraform-ha-sg-instance"
    description = "Morpheus HA Server SG"
    vpc_id = data.terraform_remote_state.vpc.outputs.current_vpc_id
}

resource "aws_security_group_rule" "ingress_ssh" {
        type = "ingress"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
        security_group_id = aws_security_group.ha_instance.id
}

resource "aws_security_group_rule" "ingress_https" {
        type = "ingress"
        from_port = var.https_port
        to_port = var.https_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
        security_group_id = aws_security_group.ha_instance.id
}

resource "aws_security_group_rule" "ingress_custom_http" {
        type = "ingress"
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
        security_group_id = aws_security_group.ha_instance.id
}

resource "aws_security_group_rule" "egress_allow_all" {
        type = "egress"
        from_port = 0
        to_port = 0
        protocol = "all"
        cidr_blocks = [ "0.0.0.0/0" ]
        security_group_id = aws_security_group.ha_instance.id
}



# resource "aws_launch_configuration" "example" {
#   image_id = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
#   security_groups = [ aws_security_group.instance.id ]
#   key_name = "MyKeyPair"

#   root_block_device  {
#       volume_size = 30
#       volume_type = "gp2"
#   }

#   user_data = <<-EOF
#   #!/bin/bash
#   echo "Hello World!" > index.html
#   nohup busybox httpd -f -p ${var.server_port} &
#   EOF


#   lifecycle {
#     create_before_destroy = true
#   }

# }
#  resource "aws_autoscaling_group" "example" {
#      min_size = 2
#      max_size = 4

#      launch_configuration = aws_launch_configuration.example.name
#      vpc_zone_identifier = data.aws_subnet_ids.default.ids
#      target_group_arns = [ aws_lb_target_group.asg.arn ]
#      health_check_type = "ELB"

#      tag {
#          key = "Name"
#          value = "terraform-asg_example"
#          propagate_at_launch = true
#      }
#  }

# resource "aws_lb" "example" {
#     name = "tf-alb-example"
#     load_balancer_type = "application"
#     subnets = data.aws_subnet_ids.default.ids
#     security_groups = [ aws_security_group.alb.id ]

# }

# resource "aws_lb_listener" "http" {
#     load_balancer_arn = aws_lb.example.arn
#     port = 80
#     protocol = "HTTP"

#     default_action {
#       type = "fixed-response"

#       fixed_response {
#           content_type = "text/plain"
#           message_body = "404: Page not found by test ALB"
#           status_code = 404
#       }
#     }
# }

# resource "aws_lb_listener_rule" "asg" {
#     listener_arn = aws_lb_listener.http.arn
#     priority = 100

#     condition {
#         path_pattern {
#             values = ["*"]
#         }
#     }

#     action  {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.asg.arn

#     }
# }

# resource "aws_security_group" "alb" {
#     name = "tf-example-alb-asg"

#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

# }

# resource "aws_lb_target_group" "asg" {
#     name = "tf-asg-example"
#     port = var.server_port
#     protocol = "HTTP"
#     vpc_id = data.aws_vpc.default.id

#     health_check {
#         path = "/"
#         protocol = "HTTP"
#         matcher = "200"
#         interval = 15
#         timeout = 3
#         healthy_threshold = 2
#         unhealthy_threshold = 2
#     }
# }


data "template_file" "user_data" {
    template = file("userdata.sh")

    vars = {
        server_port = var.server_port
        morpheus_package = var.morpheus_package

        mysql_host = data.terraform_remote_state.mysql.outputs.mysql_host
        mysql_morpheus_db = data.terraform_remote_state.mysql.outputs.mysql_morpheus_db
        mysql_morpheus_db_user = data.terraform_remote_state.mysql.outputs.mysql_morpheus_db_user
        mysql_morpheus_password = data.terraform_remote_state.mysql.outputs.mysql_morpheus_password

        elastic_cluster = data.terraform_remote_state.elastic.outputs.elastic_cluster
        elastic_es_hosts = data.terraform_remote_state.elastic.outputs.elastic_es_hosts
        elastic_use_tls = data.terraform_remote_state.elastic.outputs.elastic_use_tls
        elastic_auth_user = data.terraform_remote_state.elastic.outputs.elastic_auth_user
        elastic_auth_password = data.terraform_remote_state.elastic.outputs.elastic_auth_password

        rabbitmq_vhost = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_vhost
        rabbitmq_queue_user = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_queue_user
        rabbitmq_queue_user_password = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_queue_user_password
        rabbitmq_host = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_host
        rabbitmq_port = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_port
        rabbitmq_heartbeat = data.terraform_remote_state.rabbitmq.outputs.rabbitmq_heartbeat
        
        vpc_current_vpc_id = data.terraform_remote_state.vpc.outputs.current_vpc_id
        vpc_default_vpc_id = data.terraform_remote_state.vpc.outputs.default_vpc_id
    }
}

resource "aws_instance" "example" {
  count = 1

  ami = var.instance_ami
  instance_type = var.instance_instance_type
  vpc_security_group_ids = [ aws_security_group.ha_instance.id ]
  key_name = var.instance_key_name
  monitoring = var.instance_enable_monitoring
 

  root_block_device  {
      volume_size = 40
      volume_type = "gp2"
  }

  user_data = data.template_file.user_data.rendered

  tags = {
      Name = "terraform-morpheus-ha-${count.index}"
  }

}
