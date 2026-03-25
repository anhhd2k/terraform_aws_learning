terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "statefile-terraform-bucket-1231234124"
    key = "dev/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = "true"
    use_lockfile = true
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
