################################################################################
# VPC Resource
################################################################################

resource "aws_vpc" "this" {
  count               = var.create_vpc ? 1 : 0
  cidr_block          = var.cidr
  instance_tenancy    = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support  = var.enable_dns_support

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags
  )
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  count  = var.create_vpc && var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags
  )
}

################################################################################
# Public Subnets
################################################################################

locals {
  create_public_subnets = var.create_vpc && length(var.public_subnets) > 0
}

resource "aws_subnet" "public" {
  count = local.create_public_subnets ? length(var.public_subnets) : 0

  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block           = element(var.public_subnets, count.index)
  vpc_id               = aws_vpc.this[0].id

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    { Name = format("${var.name}-%s-%s", var.public_subnet_suffix, element(var.azs, count.index)) },
    var.tags,
    var.public_subnet_tags
  )
}

resource "aws_route_table" "public" {
  count  = local.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    { "Name" = "${var.name}-${var.public_subnet_suffix}" },
    var.tags,
    var.public_route_table_tags
  )
}

resource "aws_route_table_association" "public" {
  count = local.create_public_subnets ? length(var.public_subnets) : 0

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route" "public_internet_gateway" {
  count = local.create_public_subnets && var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

################################################################################
# Private Subnets
################################################################################

locals {
  create_private_subnets = var.create_vpc && length(var.private_subnets) > 0
}

resource "aws_subnet" "private" {
  count = local.create_private_subnets ? length(var.private_subnets) : 0

  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block           = element(var.private_subnets, count.index)
  vpc_id               = aws_vpc.this[0].id

  tags = merge(
    { Name = format("${var.name}-%s-%s", var.private_subnet_suffix, element(var.azs, count.index)) },
    var.tags,
    var.private_subnet_tags
  )
}

resource "aws_route_table" "private" {
  count  = local.create_private_subnets ? (var.one_nat_gateway_per_az ? length(var.azs) : 1) : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = var.one_nat_gateway_per_az ? format("${var.name}-%s-%s", var.private_subnet_suffix, element(var.azs, count.index)) : "${var.name}-${var.private_subnet_suffix}"
    },
    var.tags,
    var.private_route_table_tags
  )
}

resource "aws_route_table_association" "private" {
  count = local.create_private_subnets ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[var.one_nat_gateway_per_az ? count.index : 0].id
}

# NOTE: NAT Gateway and its routes are omitted for brevity as per module use case.
