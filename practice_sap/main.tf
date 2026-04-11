resource "aws_security_group" "allow_tls"{
    name = "allow_tls"
    description = "Allow TLS inbound traffic and  all outbound traffic"
    vpc_id = data.aws_vpc.default.id
    
    tags = {
        Name = "allow_tls"
    }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "aws-key"
  public_key = file("C:\\Users\\Admin\\vscode\\terraform_aws_learning\\practice_sap\\resource\\key.pub")
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4 = var.my_public_ip
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp"{
    security_group_id = aws_security_group.allow_tls.id

    ip_protocol = "icmp"
    cidr_ipv4   = var.my_public_ip

    from_port = -1
    to_port   = -1

    description = "Allow ICMP (ping) from within VPC"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.allow_tls.id
    ip_protocol = "tcp"
    cidr_ipv4 =  var.my_public_ip
    
    from_port = 22
    to_port = 22

    description = "Allow ssh from internet"
  
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}




resource "aws_instance" "app" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id =  data.aws_subnets.default.ids[0]

  key_name = aws_key_pair.ec2_key_pair.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_tls.id
  ]
}