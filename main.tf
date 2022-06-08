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
  ami             = "ami-0487b1fe60c1fd1a2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.security_grp.name]
  tags= {
    Name = "ec2-instance"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "security_grp" {
  name        = "EC2-security-group"
  description = "security group for EC2 instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags= {
    Name = "EC2-security-group"
  }
}
