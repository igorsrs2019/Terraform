terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.5.3"
}


  #Path credentials provider

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region  = var.region
}


 # Create Security Group  allow ssh/htp 

resource "aws_security_group" "allow_ssh_http" {
  name        =  var.name_security_group
  description = "Allow ssh and http inbound traffic"
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
    Name = "Allow HTTP"
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  # Create Security Group Load Balance
  resource "aws_security_group" "allow_http" {
  name        =  var.name_security_group_elb
  description = "Allow http"
  vpc_id      =  var.vpc_id_security_group

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
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
    Name = "security-group-balance"
    
  }

  # Create Loadbalance

  resource "aws_lb" "elb"{
   Name        = "teste-lb"
   internal    = "false"
   load_balancer_type = "application"
   security_groups = [aws_security_group.lb_sg.id]
   subnets         = [aws_subnet.public.subnet_id_aws_elb.id]

   instances = ["${aws_instance.webserver001.id}", "${aws_instance.webserver002.id}"]
   availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
   enable_deletion_protection =  true

   #Listener ports ELB
    
  listener{
   instance_port = 80
   instance_protocol = "tcp"
   lb_port = 80
   lb_protocol = "tcp"

  }
   
   tags = {

    Environment = "LoadBalance"
  }

   # Health check instances in balancer  
   
 health_check {
  target = "HTTP:80/"
  healthy_threshold = 2
  unhealthy_threshold = 2
  interval = 30
  timeout = 5
  
 tags = {
   name = "elb"

 }

 }




  }


}
  # Create primary EC2

  

  resource "aws_instance" "webserver001" {
  ami           = var.ami_aws_instance
  instance_type          = var.type_aws_instance
  key_name               = var.key_aws_instance
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = var.subnet_id_aws_webserver001
  associate_public_ip_address = true

  tags = {
    Name  = "Webserver001"
    
  }


  }
}

    # Create secondary EC2
  resource "aws_instance" "webserver002" {
  ami           = var.ami_aws_instance
  instance_type          = var.type_aws_instance
  key_name               = var.key_aws_instance
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = var.subnet_id_aws_webserver002
  associate_public_ip_address = true

  tags = {
    Name  = "Webserver002"
    
  }
 


  }
