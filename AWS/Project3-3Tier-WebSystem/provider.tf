terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "CloudEngineerLab"
      Environment = "Development"
      ManagedBy   = "Terraform"
      ProjectID   = "AWS-Project3-3Tier"
    }
  }
}