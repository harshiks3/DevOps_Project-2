provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "demo_Server" {
    ami = "ami-053b12d3152c0cc71"
    instance_type = "t2.micro"
    key_name = "terraform_key_demo_Server"  
}