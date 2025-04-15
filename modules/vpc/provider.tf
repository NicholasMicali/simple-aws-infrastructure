################################################################################
# Provider Configuration
################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

################################################################################
# Region Variable
################################################################################

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}
