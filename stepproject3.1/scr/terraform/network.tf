variable "key_name" {
  default = "webseeker_key" 
}

# VPC
resource "aws_vpc" "vpc_1webseeker" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_1webseeker"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_1webseeker" {
  vpc_id = aws_vpc.vpc_1webseeker.id
  tags = {
    Name = "igw_1webseeker"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet_1webseeker" {
  vpc_id                  = aws_vpc.vpc_1webseeker.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_1webseeker"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet_1webseeker" {
  vpc_id            = aws_vpc.vpc_1webseeker.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "private_subnet_1webseeker"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt_1webseeker" {
  vpc_id = aws_vpc.vpc_1webseeker.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1webseeker.id
  }
  tags = {
    Name = "public_rt_1webseeker"
  }
}

resource "aws_route_table_association" "public_assoc_1webseeker" {
  subnet_id      = aws_subnet.public_subnet_1webseeker.id
  route_table_id = aws_route_table.public_rt_1webseeker.id
}

# NAT Gateway
resource "aws_eip" "nat_eip_1webseeker" {
  domain = "vpc"
  tags = {
    Name = "nat_eip_1webseeker"
  }
}

resource "aws_nat_gateway" "nat_1webseeker" {
  allocation_id = aws_eip.nat_eip_1webseeker.id
  subnet_id     = aws_subnet.public_subnet_1webseeker.id
  tags = {
    Name = "nat_1webseeker"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt_1webseeker" {
  vpc_id = aws_vpc.vpc_1webseeker.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1webseeker.id
  }
  tags = {
    Name = "private_rt_1webseeker"
  }
}

resource "aws_route_table_association" "private_assoc_1webseeker" {
  subnet_id      = aws_subnet.private_subnet_1webseeker.id
  route_table_id = aws_route_table.private_rt_1webseeker.id
}
