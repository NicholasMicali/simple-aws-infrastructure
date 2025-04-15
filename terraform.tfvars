# Terraform variables configuration

# AWS Provider settings
aws_region = "us-east-1"

# Project settings
project_name = "terraform-test"
environment  = "dev"

# VPC settings
vpc_name    = "test-vpc"
vpc_cidr    = "10.0.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

# Security settings
# IMPORTANT: Replace with your own IP address for better security
ssh_allowed_cidr = "0.0.0.0/0"  # Update this to your IP with /32 suffix

# EC2 instance settings
instance_name   = "test-ec2"
# ami_id is not set, which will make the module use the latest Amazon Linux 2 AMI
instance_type   = "t2.micro"
key_name        = "my-key-pair"  # Replace with your actual key pair name
root_volume_size = 8
create_elastic_ip = true
