variable "instance_type" {
    description = "EC2 instace type for the application"
    type = string 

    validation {
      condition = contains(["t3.micro", "t2.micro"], var.instance_type)
      error_message = "Instance type must be t2.micro or t3.micro"
    }
}


variable "my_public_ip" {
  description = "my public cidr_ip address"
  type = string
}