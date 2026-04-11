# -----------------------------
# Provider Configuration
# -----------------------------
provider "aws" {
  region = var.aws_region
}

# -----------------------------
# Variables
# -----------------------------
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# -----------------------------s
# Data Sources
# -----------------------------

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets in that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# -----------------------------
# Resource
# -----------------------------
resource "aws_instance" "example" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"

  # Pick first subnet
  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name = "aws-study"
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "instance_id" {
  value = aws_instance.example.id
}

output "public_ip" {
  value = aws_instance.example.public_ip
}