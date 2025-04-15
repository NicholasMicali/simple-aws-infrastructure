output "id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.this[0].id
}

output "arn" {
  description = "The ARN of the EC2 instance."
  value       = aws_instance.this[0].arn
}

output "instance_state" {
  description = "The state of the instance (e.g., running, stopped)."
  value       = aws_instance.this[0].instance_state
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface."
  value       = aws_instance.this[0].primary_network_interface_id
}

output "private_dns" {
  description = "The private DNS name assigned to the instance."
  value       = aws_instance.this[0].private_dns
}

output "public_dns" {
  description = "The public DNS name assigned to the instance (if applicable)."
  value       = aws_instance.this[0].public_dns
}

output "public_ip" {
  description = "The public IP address assigned to the instance (or via Elastic IP)."
  value       = length(aws_eip.this) > 0 ? aws_eip.this[0].public_ip : aws_instance.this[0].public_ip
}

output "private_ip" {
  description = "The primary private IP address of the instance."
  value       = aws_instance.this[0].private_ip
}

output "ami" {
  description = "The AMI ID used to launch the instance."
  value       = aws_instance.this[0].ami
}

output "availability_zone" {
  description = "The Availability Zone where the instance was launched."
  value       = aws_instance.this[0].availability_zone
}
