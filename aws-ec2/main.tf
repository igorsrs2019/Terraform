terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.5.3"
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region  = var.region
}

resource "aws_security_group" "allow_ssh" {
  name        =  var.name_security_group
  description = "Allow ssh inbound traffic"
  vpc_id      =  var.vpc_id_security_group

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_SSH"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "ec2-instance"
  ami           = var.ami_aws_instance
  instance_type          = var.type_aws_instance
  key_name               = var.key_aws_instance
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = var.subnet_id_aws_instance
  associate_public_ip_address = true

  tags = {
    Name  = "Minha primeira Maquina"
    
  }
}

