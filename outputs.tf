# Output values from the AWS infrastructure deployment

# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# EC2 instance outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "security_group_id" {
  description = "ID of the security group attached to the instance"
  value       = aws_security_group.ec2_sg.id
}

output "ssh_connection_string" {
  description = "SSH connection string to connect to the instance"
  value       = "ssh -i /path/to/${var.key_name}.pem ec2-user@${module.ec2_instance.public_ip}"
}
