# 🏗 VPC
resource "aws_vpc" "this" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# 🌐 Публичная подсеть
resource "aws_subnet" "public" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.this[0].id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-subnet-public"
  }
}

# 🔒 Приватная подсеть
resource "aws_subnet" "private" {
  cidr_block = var.private_subnet_cidr
  vpc_id     = aws_vpc.this[0].id

  tags = {
    Name = "${var.name_prefix}-subnet-private"
  }
}

# 🚀 Интернет-шлюз
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# 🌍 Elastic IP для NAT
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

# 🔁 NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.name_prefix}-nat"
  }
}

# 🛣 Публичная таблица маршрутов
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = "${var.name_prefix}-rt-public"
  }
}

# 🚦 Маршрут из публичной подсети в интернет
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# 🔗 Ассоциация публичной подсети с Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 🛣 Приватная таблица маршрутов
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = "${var.name_prefix}-rt-private"
  }
}

# 🚦 Маршрут из приватной подсети через NAT
resource "aws_route" "private_to_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# 🔗 Ассоциация приватной подсети с Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
