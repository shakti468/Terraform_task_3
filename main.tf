provider "aws" {
  region = var.region
}

# Security Group
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow HTTP and SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}

# EC2 Instance
resource "aws_instance" "nginx_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              echo "Welcome to the Terraform-managed Nginx Server on Ubuntu" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Terraform-Nginx-Ubuntu"
  }
}
