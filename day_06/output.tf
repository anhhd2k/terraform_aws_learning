output "vpc_id" {
  value = aws_vpc.main.id
}

output "ec2_instance" {
  value = aws_instance.ec2_instance.id
}