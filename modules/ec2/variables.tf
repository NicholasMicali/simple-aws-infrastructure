variable "name" {
  description = "The name of the EC2 instance."
  type        = string
  default     = null
}

variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "putin_khuylo" {
  description = "Agreement flag regarding geopolitical statement. Set to true to proceed."
  type        = bool
  default     = true
}

variable "ami" {
  description = "ID of AMI to use for the instance. If null, ami_ssm_parameter is used."
  type        = string
  default     = null
}

variable "ami_ssm_parameter" {
  description = "SSM parameter name for the AMI ID (used if ami is null)."
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "instance_type" {
  description = "The type of instance to start (e.g., t3.micro, m5.large)."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for SSH access."
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script to provide when launching the instance."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Base64-encoded user data (for binary content like gzipped scripts)."
  type        = string
  default     = null
}

// Network configuration
variable "subnet_id" {
  description = "The VPC Subnet ID to launch the instance in. Provide a public subnet ID."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "Optional: Assign a specific private IP address within the subnet."
  type        = string
  default     = null
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when destination does not match."
  type        = bool
  default     = null
}

variable "availability_zone" {
  description = "Optional: Availability Zone to launch the instance in."
  type        = string
  default     = null
}

// Storage configuration
variable "root_block_device" {
  description = "Customize the root block device (e.g., size, type, encryption). List of maps."
  type        = list(any)
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach. List of maps."
  type        = list(any)
  default     = []
}

// Metadata service options
variable "metadata_options" {
  description = "Customize metadata service options (e.g., http_tokens)."
  type        = map(string)
  default = {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }
}

// Instance settings
variable "monitoring" {
  description = "Enable detailed CloudWatch monitoring."
  type        = bool
  default     = null
}

variable "disable_api_termination" {
  description = "Enable termination protection for the instance."
  type        = bool
  default     = null
}

variable "disable_api_stop" {
  description = "Enable stop protection for the instance."
  type        = bool
  default     = null
}

// Elastic IP options
variable "create_eip" {
  description = "Set to true to create and associate an Elastic IP address with the instance."
  type        = bool
  default     = false
}

variable "eip_domain" {
  description = "The domain for the Elastic IP. Should be set to \"vpc\" for VPC instances."
  type        = string
  default     = "vpc"
}

variable "eip_tags" {
  description = "Additional tags to add to the created Elastic IP."
  type        = map(string)
  default     = {}
}

// Tagging
variable "tags" {
  description = "A map of tags to assign to all resources created by the module."
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "Additional tags specific to the EC2 instance."
  type        = map(string)
  default     = {}
}

// AWS region
variable "region" {
  description = "AWS region to deploy the instance."
  type        = string
  default     = "us-east-1"
}

// Spot instance options (not used in basic on-demand configuration)
variable "create_spot_instance" {
  description = "Set to true to provision a Spot instance instead of on-demand."
  type        = bool
  default     = false
}
