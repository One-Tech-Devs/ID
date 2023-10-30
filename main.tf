provider "aws" {
  region = "us-east-1"  # Escolha a região que preferir
}

resource "aws_security_group" "security_group_onetech" {
  name        = "security_group_onetech"
  description = "Security Group para SSH, HTTP e porta 8000"

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

  ingress {
    from_port   = 5034
    to_port     = 5034
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

resource "aws_instance" "onetech_vm" {
  ami           = "ami-053b0d53c279acc90"  # AMI do Ubuntu 18.04
  instance_type = "t2.micro"  # Tipo de instância
  key_name      = aws_key_pair.onetech_keypair.key_name   
  vpc_security_group_ids = [aws_security_group.security_group_onetech.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y software-properties-common
              sudo apt-add-repository --yes --update ppa:ansible/ansible
              sudo apt-get install -y ansible
              EOF

  tags = {
    Name        = "onetech_vm"
    Environment = "dev"
    Application = "backend"
    Class       = "DevOps"
    Origem      = "Meu segundo git actions"
  }
}
