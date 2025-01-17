terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bucket-sentry-project"
    key            = "terraform.tfstate"
    region         = "ap-south-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    acl            = "private"
  }
}

provider "aws" {
  region = var.region
  # profile = var.aws_profile
}