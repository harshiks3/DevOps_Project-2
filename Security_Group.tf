provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "demo_Server" {
    ami = "ami-053b12d3152c0cc71"
    instance_type = "t2.micro"
    security_groups = [ "demo_sg" ]
    key_name = "terraform_key_demo_Server"  
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"


  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "demo_sg" {
  security_group_id = aws_security_group.demo_sg
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "demo_sg" {
  security_group_id = aws_security_group.demo_sg
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}