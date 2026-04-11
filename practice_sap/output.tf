output "vpc_id" {
  description = "ID of VPC Default"
  value = data.aws_subnets.default.ids
}

output "ami" {
  description = "Private IP address of the AMI"
  value = data.aws_ami.ubuntu.id
}

output "ip_public_address" {
    description = "public IP address of the Ec2 isntance"
    value = aws_instance.app.public_ip
}