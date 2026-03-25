terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

#Create s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "tutorials-03-bucket"

  tags = {
    Name        = "Tutorial 2.2"
    Environment = "Dev"
  }
}
