provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg1" {
  name = "web-sg1"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-03ea746da1a2e36e7"   # Amazon Linux 2
  instance_type = "t3.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg1.name]

  tags = {
    Name = "ci-cd-demo"
  }
}
