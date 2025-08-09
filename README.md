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

  
