################################################################################
# VPC Core Configuration
################################################################################

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

################################################################################
# Subnet Configuration
################################################################################

variable "public_subnets" {
  description = "A list of public subnets inside the VPC. Must be one per AZ specified in azs."
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC. Must be one per AZ specified in azs."
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Specify true to assign a public IP address to instances launched in the public subnet"
  type        = bool
  default     = false
}

################################################################################
# Internet Gateway & Routing
################################################################################

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and its related routes"
  type        = bool
  default     = true
}

################################################################################
# Tagging
################################################################################

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

################################################################################
# Naming Suffixes
################################################################################

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private"
}

################################################################################
# NAT Gateway Option (Simplified)
################################################################################

variable "one_nat_gateway_per_az" {
  description = "If true, creates one NAT Gateway per AZ for private subnet routing"
  type        = bool
  default     = false
}
