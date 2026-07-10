variable "instance_type" {

  description = "EC2 instance type"

  type = string

}


variable "vpc_cidr" {

  description = "VPC CIDR block"

  type = string

}


variable "public_subnet_cidr" {

  description = "Public subnet CIDR block"

  type = string

}