terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_launch_template" "lauch_template" {
  description   = "Lauch template for EC2 Autoscaling group"
  name_prefix   = "iac-task"
  instance_type = "t2.micro"
  image_id      = "ami-06640050dc3f556bb"
  key_name      = "Rhel"

}

resource "aws_autoscaling_group" "autoscaling_group" {
  min_size           = 3
  desired_capacity   = 6
  max_size           = 8
  availability_zones = ["us-east-1a"]

  launch_template {
    id      = aws_launch_template.lauch_template.id
    version = "$Latest"
  }
}

resource "aws_lb" "load_balancer" {
  name               = "ApplicationLoadBalancer-IAC-Task"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-05f33853ee94d2d9c", "subnet-049f8d1db492930e4", "subnet-03ed467fc763feb6b"]

  enable_deletion_protection = true
}

# resource "aws_instance" "web_server" {
#   ami           = "ami-06640050dc3f556bb"
#   instance_type = "t2.micro"
#   key_name      = "Rhel"

#   tags = {
#     Name = "WebServerInstance-IAC-Task"
#   }
# }
