variable  "region" {
  default = "us-east-1"
}

variable "name_security_group" {
  default= "allow_ssh_http" 
}

variable "name_security_group_elb" {
  default= "allow_http" 
}

variable "vpc_id_security_group" {
  default= "vpc-02ca2e9c5b2f8f744" 
}

variable "ami_aws_instance" {
  default= "ami-0261755bbcb8c4a84" 
}


variable "type_aws_instance" {
  default= "t2.micro" 
}

variable "subnet_id_aws_webserver001" {
  default= "subnet-0e5e042cfbd42b3dc" 
}

variable "subnet_id_aws_webserver002" {
  default= "subnet-0252700f2d42780e3" 
}

variable "subnet_id_aws_elb" {
  default= "subnet-0a8f18c3bf03781f7" 
}



variable "key_aws_instance" {
  default= "LINUX" 
}

