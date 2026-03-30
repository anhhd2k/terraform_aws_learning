terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.region
}

# -------------------
# Variables
# -------------------

variable "enviroment" {
  default = "dev"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "ami" {
  default = "ami-04d7457c43c292911"
}

variable "instance_type" {
  default = "t3.micro"
}

# -------------------
# Locals
# -------------------

locals {
  prefix_name = "${var.region}-${var.enviroment}"
}

# -------------------
# VPC
# -------------------

resource "aws_vpc" "main" {
  cidr_block = "10.16.0.0/16"

  tags = {
    Name = "vpc-${local.prefix_name}"
  }
}

# -------------------
# Subnet (PUBLIC)
# -------------------

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.16.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-${local.prefix_name}"
  }
}

# -------------------
# Internet Gateway
# -------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${local.prefix_name}"
  }
}

# -------------------
# Route Table
# -------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt-${local.prefix_name}"
  }
}

# Route to Internet
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate subnet with route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}

# -------------------
# Security Group
# -------------------

resource "aws_security_group" "ec2_sg" {
  name   = "${local.prefix_name}-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ restrict in real use
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${local.prefix_name}"
  }
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "ec2_instance" {
  value = aws_instance.ec2_instance.id
}



# -------------------
# EC2 Instance
# -------------------

resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "ec2-${local.prefix_name}"
  }
}