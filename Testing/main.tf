
# Terraform Block for Terraform settings
# Set a version in most cases because if you don't it will always use the latest version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


# Providers Block, This defines provider e.g "aws"
# You cann use multiple provider blocks so that you can use multiple cloud providers, etc
provider "aws" {
  region = "us-east-1"
}


# Resource Block defines components of your infrastructure.
# Can be physical (ec2) or it logical (Heroku App)
# There will always be two strings before the block
# Arguments are for machine size, image, names, vpc Id, etc
resource "aws_instance" "app_server" {
  ami           = "ami-095d7f6e44fd11fde"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
