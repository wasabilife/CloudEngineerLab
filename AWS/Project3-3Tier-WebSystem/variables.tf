variable "aws_region" {
  type    = string
  default = "ap-northeast-3"
}

variable "project_name" {
  type    = string
  default = "cloudlab-p3"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)

  default = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
}

variable "app_subnet_cidrs" {
  type = list(string)

  default = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]
}

variable "db_subnet_cidrs" {
  type = list(string)

  default = [
    "10.20.21.0/24",
    "10.20.22.0/24"
  ]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_username" {
  type      = string
  sensitive = true
  default   = "cloudlabadmin"
}