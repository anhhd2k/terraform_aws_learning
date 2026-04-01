variable "enviroment" {
  default = "dev"
  type = string
}

variable "region" {
  default = "ap-southeast-1"
  type = string
}

variable "ami" {
  default = "ami-04d7457c43c292911"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  type = number
  description = "number of EC2 instances to increase"
}