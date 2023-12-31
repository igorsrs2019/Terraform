variable  "region" {
  default = "us-east-1"
}

variable "name_security_group" {
  default= "allow_ssh" 
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

variable "subnet_id_aws_instance" {
  default= "subnet-0a8f18c3bf03781f7" 
}

variable "key_aws_instance" {
  default= "LINUX" 
}

