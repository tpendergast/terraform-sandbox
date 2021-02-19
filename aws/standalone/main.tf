provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet_ids" "default" {
    vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    description = "Standalone Morpheus Server SG"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
    }

    ingress {
        from_port = var.https_port
        to_port = var.https_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
    }

    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = var.input_cidr_blocks
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
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

resource "aws_instance" "example" {
  count = 1

  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.large"
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  key_name = "MyKeyPair"

  root_block_device  {
      volume_size = 40
      volume_type = "gp2"
  }

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello World ${count.index}" > index.html
  nohup busybox httpd -f -p ${var.server_port} &
  cd /home/ubuntu
  apt-get update
  curl --output ${var.morpheus_package} https://downloads.morpheusdata.com/files/${var.morpheus_package}
  apt-get install ./${var.morpheus_package}
  morpheus-ctl reconfigure
  EOF

  tags = {
      Name = "terraform-example ${count.index}"
  }

}