terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}


provider "aws" {

  region = "ap-northeast-3"

}
terraform {
  backend "s3" {
    bucket         = "cloud-engineer-lab-terraform-state-001"
    key            = "terraform.tfstate"
    region         = "ap-northeast-3"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}