# EC2 Nginx Deployment with Terraform

## 📌 Overview
This project demonstrates the use of **Infrastructure as Code (IaC)** principles by creating and managing AWS resources using **Terraform**.  
It provisions an **EC2 instance** running an **Nginx web server** on **Ubuntu 20.04 LTS** with a custom HTML page.

---

## 📂 Project Structure
```bash
Terraform_task_3/
├── main.tf # Terraform configuration for AWS provider, EC2, and Security Group
├── variables.tf # Variables for instance type, key name, and AWS region (optional)
├── outputs.tf # Outputs the public IP of the EC2 instance
├── README.md # Documentation and usage guide
```


---

## 🛠️ Resources Created
- **AWS EC2 Instance**
  - Type: `t2.micro`
  - OS: Ubuntu 20.04 LTS
  - Installed Nginx with custom index page content:
    ```
    Welcome to the Terraform-managed Nginx Server on Ubuntu
    ```
- **Security Group**
  - Allows inbound **HTTP (port 80)**
  - Allows inbound **SSH (port 22)**
- **User Data Script**
  - Installs Nginx automatically
  - Deploys custom HTML file

---

## ⚙️ Prerequisites
Before you begin, ensure you have:
- An **AWS account** with access credentials (AWS Access Key & Secret Key)
- **Terraform** installed ([Download Terraform](https://developer.hashicorp.com/terraform/downloads))
- Configured **AWS CLI** or environment variables for authentication:
  ```bash
  aws configure
  ```
# Terraform
## main.tf
```bash
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
```

## variable.tf
```bash
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "Default VPC ID"
  type        = string
  default     = "vpc-0056d809452f9f8ea" 
}

variable "subnet_id" {
  description = "Subnet ID in default VPC"
  type        = string
  default     = "subnet-0c1842aca7dc1b6b0"
}

variable "ami_id" {
  description = "Ubuntu 20.04 LTS AMI ID"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
  default     = "Shakti-b10"
}
```

## output.tf
```bash
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.nginx_server.public_ip
}
```

# Initialize Terraform
```bash
terraform init
```

## Screenshots
<img width="867" height="450" alt="image" src="https://github.com/user-attachments/assets/c672588c-ba29-4763-a887-2680a343d220" />

# Preview changes
```bash
terraform plan
```
## Screenshots
<img width="978" height="512" alt="image" src="https://github.com/user-attachments/assets/37c72f17-185b-4ebb-8c96-3811ac3101ef" />

# Apply the infrastructure
```bash
terraform apply -auto-approve
```

## Screenshots 
<img width="1276" height="536" alt="image" src="https://github.com/user-attachments/assets/b2f498bd-ab19-4396-b1bc-b4160fe8bb91" />
<img width="1047" height="565" alt="image" src="https://github.com/user-attachments/assets/eb332a17-94b7-4c5c-bcca-633a7188498c" />

# AWS EC2 Instance Running
<img width="1653" height="903" alt="Screenshot 2025-08-08 205647" src="https://github.com/user-attachments/assets/379fb85e-334b-4d21-8a80-0e6b28342d80" />


---

# Nginx Welcome Page in Browser
<img width="844" height="596" alt="Screenshot 2025-08-08 205711" src="https://github.com/user-attachments/assets/9bb12bd9-4a3f-48dd-9cc1-a041dd6faa0b" />



---


# 🗑️ Teardown
```bash
terraform destroy -auto-approve
```
# Screenshots 
<img width="1032" height="491" alt="image" src="https://github.com/user-attachments/assets/cd3bc9f7-155e-48d8-8c67-24c5ddfe72b3" />


---

# Notes
- The EC2 instance runs in the default VPC.
- No extra VPC, subnets, or gateways are created.
