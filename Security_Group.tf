provider "aws" {
  alias  = "south"
  region = "ap-south-1"
}

# Create the security group
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "New_Security_group_created_from_terraform_code"
  }
}

# Create the EC2 instance and reference the security group by ID
resource "aws_instance" "demo_Server_for_sg" {
  ami             = "ami-053b12d3152c0cc71"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.demo_sg.name]  # Referencing by name is okay for EC2 instance
  key_name        = "terraform_key_demo_Server"

  tags = {
    Name = "EC2_created_from_terraform_code"
  }
}

# Create an ingress rule for the security group
resource "aws_security_group_rule" "demo_sg_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.demo_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

# Create an egress rule for the security group
resource "aws_security_group_rule" "demo_sg_egress" {
  type  = "egress"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.demo_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"  # All protocols (equivalent to "all ports")
}
