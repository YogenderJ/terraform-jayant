terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "github-actions-terraform-ec2"

    workspaces {
      name = "terraform-github-2"
    }
  }
}


resource "aws_instance" "EC2-Instance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

#Create security group with firewall rules
resource "aws_security_group" "security_grp" {
  name        = var.security_group
  description = "security group for EC2 instance"


 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

#------------------------------Variable.tf--------------------------------

variable "aws_region" {
       description = "The AWS region to create things in."
       default     = "us-west-1"
}


variable "instance_type" {
    description = "instance type for ec2"
    default     =  "t2.micro"
}

variable "security_group" {
    description = "Name of security group"
    default     = "EC2-security-group"
}

variable "tag_name" {
    description = "Tag Name of for Ec2 instance"
    default     = "ec2-instance"
}
variable "ami_id" {
    description = "AMI for Ubuntu Ec2 instance"
    default     = "ami-0487b1fe60c1fd1a2"
}
