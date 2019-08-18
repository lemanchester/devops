locals {
  all_tags = {
    Environment = var.env
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = merge(map("Name", format("%s-vpc", var.env)), local.all_tags, var.vpc_tags)
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id
  tags   = merge(map("Name", format("%s-igw", var.env)), local.all_tags)
}

# Routing table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = merge(map("Name", format("%s-rtb-public", var.env)), local.all_tags)
}

# Public subnets
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = "${var.region}${element(var.azs, count.index)}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.default"]

  tags = merge(map("Name", format("%s-subnet-public-%s", var.env, var.azs[count.index])), local.all_tags, var.public_subnet_tags)
}

# Associate the routing table to public subnets
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

# NAT Gateway
resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # Attaching to the first public subnet we create
  depends_on    = ["aws_internet_gateway.default"]
}

# Routing table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }

  tags = merge(map("Name", format("%s-rtb-private", var.env)), local.all_tags)
}

# Public subnets
resource "aws_subnet" "private" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  availability_zone       = "${var.region}${element(var.azs, count.index)}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_nat_gateway.default"]

  tags = merge(map("Name", format("%s-subnet-private-%s", var.env, element(var.azs, count.index))), local.all_tags, var.private_subnet_tags)
}

/* Associate the routing table to public subnets */
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
