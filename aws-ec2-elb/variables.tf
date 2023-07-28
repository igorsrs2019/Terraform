variable  "region" {
  default = "us-east-1"
}

variable "name_security_group" {
  default= "allow_ssh_http" 
}


variable "vpc_id_security_group" {
  default= "vpc-0ab691ed4685b2ddc" 
}

variable "ami_aws_instance" {
  default= "ami-0261755bbcb8c4a84" 
}


variable "type_aws_instance" {
  default= "t2.micro" 
}

variable "subnet_id_aws_webserver001" {
  default= "subnet-0f4d38f21e3d47b60" 
}

variable "subnet_id_aws_webserver002" {
  default= "subnet-0e5698b318e1ae41a" 
}

variable "key_aws_instance" {
  default= "LINUX" 
}

