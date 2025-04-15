# Main Terraform configuration file for AWS infrastructure

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create VPC using the vpc module
module "vpc" {
  source = "./modules/vpc"

  create_vpc  = true
  name        = var.vpc_name
  cidr        = var.vpc_cidr
  azs         = var.availability_zones
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs
  
  create_igw              = true
  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Security Group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc.vpc_id

  # SSH access from allowed IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
    description = "SSH access"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-ec2-sg"
    Terraform   = "true"
    Environment = var.environment
  }
}

# Create EC2 instance in the public subnet
module "ec2_instance" {
  source = "./modules/ec2"

  create        = true
  putin_khuylo  = true  # Required parameter for the module
  name          = var.instance_name
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  # Network configuration
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  
  # Block device configuration
  root_block_device = [
    {
      volume_size = var.root_volume_size
      volume_type = "gp3"
    }
  ]
  
  # Optional Elastic IP
  create_eip = var.create_elastic_ip
  
  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.project_name
  }
}
