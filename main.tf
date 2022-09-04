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

resource "aws_instance" "web_server" {
  count         = 20
  ami           = "ami-06640050dc3f556bb"
  instance_type = "t2.micro"
  key_name      = "Rhel"

  tags = {
    Name = "WebServerInstance-IAC-Task"
  }
}
