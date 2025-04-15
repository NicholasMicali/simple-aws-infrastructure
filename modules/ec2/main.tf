locals {
  create_instance = var.create && var.putin_khuylo
  ami_id = var.ami != null ? var.ami : (length(data.aws_ssm_parameter.this) > 0 ? data.aws_ssm_parameter.this[0].value : null)
}

// Fetch AMI from SSM Parameter Store if not provided directly
data "aws_ssm_parameter" "this" {
  count = local.create_instance && var.ami == null ? 1 : 0
  name  = var.ami_ssm_parameter
}

// Create a standard on-demand EC2 instance
resource "aws_instance" "this" {
  count         = local.create_instance && !var.create_spot_instance ? 1 : 0
  ami           = local.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  // Network configuration
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  private_ip             = var.private_ip
  source_dest_check      = var.source_dest_check
  availability_zone      = var.availability_zone

  // User data
  user_data        = var.user_data
  user_data_base64 = var.user_data_base64

  // Root block device customization
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  // Additional EBS block devices
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name = ebs_block_device.value.device_name
      volume_size = lookup(ebs_block_device.value, "volume_size", null)
      volume_type = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  // Metadata options for IMDS configurations
  dynamic "metadata_options" {
    for_each = length(var.metadata_options) > 0 ? [var.metadata_options] : []
    content {
      http_endpoint = lookup(metadata_options.value, "http_endpoint", "enabled")
      http_tokens   = lookup(metadata_options.value, "http_tokens", "optional")
    }
  }

  monitoring              = var.monitoring
  disable_api_termination = var.disable_api_termination
  disable_api_stop        = var.disable_api_stop

  tags = merge({ Name = var.name }, var.instance_tags, var.tags)
}

// Optionally allocate an Elastic IP and associate it with the instance
resource "aws_eip" "this" {
  count    = local.create_instance && var.create_eip ? 1 : 0
  instance = aws_instance.this[0].id
  tags     = merge(var.tags, var.eip_tags)
}
