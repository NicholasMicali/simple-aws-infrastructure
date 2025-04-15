# Input variables for the AWS infrastructure

# AWS Provider variables
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# Project variables
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-test"
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "dev"
}

# VPC variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "test-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Security Group variables
variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the EC2 instance"
  type        = string
  default     = "0.0.0.0/0"  # WARNING: This should be restricted to your IP in production
}

# EC2 Instance variables
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "test-instance"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (optional, will use latest Amazon Linux 2 if null)"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "create_elastic_ip" {
  description = "Whether to create and attach an Elastic IP to the instance"
  type        = bool
  default     = true
}
