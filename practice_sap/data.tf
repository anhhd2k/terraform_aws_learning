data "aws_ami" "ubuntu" {
     most_recent = true

  owners = ["amazon"]  # ✅ clean + readable

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
    filter{
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}