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



