# AWS EC2 Instance Terraform Module

This module provisions a single AWS EC2 instance in a specified VPC public subnet. The instance is configured with basic parameters such as AMI, instance type, key pair, and security groups. Optional settings include Elastic IP allocation, root and additional EBS volumes, and metadata options.

## Usage

Below is an example of how to use this module:

```hcl
module "ec2_instance" {
  source = "modules/ec2"

  name                    = "single-instance"
  ami                     = null  # If null, the module will use the SSM parameter for the latest Amazon Linux 2 AMI
  instance_type           = "t3.micro"
  key_name                = "your-key-name"
  subnet_id               = "subnet-xxxxxxxx"
  vpc_security_group_ids  = ["sg-xxxxxxxx"]
  associate_public_ip_address = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Inputs

Refer to the [variables.tf](./variables.tf) for a complete listing of supported inputs.

## Outputs

The module exports the following outputs:

- **id**: The ID of the EC2 instance
- **arn**: The ARN of the EC2 instance
- **instance_state**: The state of the instance
- **primary_network_interface_id**: The primary network interface ID
- **private_dns**: The internal DNS name of the instance
- **public_dns**: The public DNS name (if applicable)
- **public_ip**: The public IP address (or Elastic IP if allocated)
- **private_ip**: The primary private IP address
- **ami**: The AMI ID used
- **availability_zone**: The Availability Zone where the instance was launched

## Notes

- Ensure that the subnet provided is a public subnet if you require internet access.
- The module uses a conditional block to fetch the AMI from AWS SSM Parameter Store if an AMI ID is not provided.
- Additional configurations for EBS block devices and metadata options are available for advanced use cases.
