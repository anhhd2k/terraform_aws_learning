resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  monitoring = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Enviroment = var.enviroment
    Name       = "${var.enviroment}-EC2-Instance"
  }
}
