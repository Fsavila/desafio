terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source = "tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}