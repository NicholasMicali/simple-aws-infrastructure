# AWS VPC Terraform Module

This Terraform module creates and manages an AWS Virtual Private Cloud (VPC) along with essential networking components including public and private subnets, route tables, and an Internet Gateway.

## Features

- Create a VPC with a specified CIDR block
- Create public subnets across defined Availability Zones with an Internet Gateway route
- Create private subnets with route table associations
- Outputs for VPC ID, subnet IDs, and route table IDs

## Usage

Example usage:

```hcl
module "vpc" {
  source = "./modules/vpc"

  name        = "my-vpc"
  cidr        = "10.10.0.0/16"
  azs         = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  
  map_public_ip_on_launch = false
  create_igw              = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Inputs

See `variables.tf` for a full list of configurable variables.

## Outputs

- `vpc_id`: The ID of the VPC
- `public_subnets`: List of public subnet IDs
- `private_subnets`: List of private subnet IDs
- And additional outputs for route tables, gateways, etc.

## Provider

This module requires the AWS provider. Ensure your AWS credentials and region are configured.

## Notes

- NAT Gateway configuration and additional features such as VPN Gateway, flow logs, and additional subnet types are not included in this basic version but can be added as needed.
