# Simple AWS Infrastructure

This Terraform project creates a basic AWS infrastructure consisting of a VPC and an EC2 instance. It's designed for learning and personal testing purposes.

## Architecture

![Infrastructure Architecture](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW0ludGVybmV0XSAtLT58U1NIIEFjY2VzcyB8IEJbSW50ZXJuZXQgR2F0ZXdheV1cbiAgICBCIC0tPiBDW1BvUDogUHVibGljIFN1Ym5ldHNdXG4gICAgQyAtLT4gRFtFQzIgSW5zdGFuY2VdXG4gICAgQyAtLT4gRVtQcml2YXRlIFN1Ym5ldHNdXG4gICAgc3ViZ3JhcGggVlBDXG4gICAgQlxuICAgIENcbiAgICBEXG4gICAgRVxuICAgIGVuZCIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In19)

## Features

- AWS VPC with public and private subnets
- Internet Gateway for external connectivity
- EC2 instance deployed in a public subnet
- Security group with SSH access for management
- Optional Elastic IP for persistent public IP address

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) (version >= 1.0.0)
2. AWS account with appropriate permissions
3. AWS CLI configured with your credentials
4. SSH key pair for EC2 instance access

## Usage

1. Clone this repository
2. Update the `terraform.tfvars` file with your specific configuration
3. Initialize Terraform:

```bash
terraform init
```

4. Review the plan:

```bash
terraform plan
```

5. Apply the configuration:

```bash
terraform apply
```

6. Connect to your instance (once deployment is complete):

```bash
ssh -i /path/to/your-key.pem ec2-user@<instance_ip>
```

## Configuration

The main configuration options are in the `terraform.tfvars` file. Important variables include:

- `aws_region`: AWS region to deploy resources in
- `key_name`: The name of your SSH key pair (must already exist in AWS)
- `ssh_allowed_cidr`: CIDR range allowed to SSH to the instance (should be restricted to your IP)
- `instance_type`: EC2 instance type
- `create_elastic_ip`: Whether to allocate an Elastic IP to the instance

## Security Notes

- The default configuration allows SSH access from any IP (`0.0.0.0/0`). For better security, restrict the `ssh_allowed_cidr` to your specific IP address.
- This project is intended for learning and personal testing - additional security measures would be needed for production environments.

## Clean Up

To destroy all resources created by this project:

```bash
terraform destroy
```

## Notes

- This setup uses a local Terraform state file, which is appropriate for personal testing. For team environments, consider using a remote state backend like S3.
- The EC2 instance uses Amazon Linux 2 by default if no AMI is specified.
