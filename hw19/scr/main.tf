terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
  required_version = "> 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}


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

# Security Group
resource "aws_security_group" "webseeker_sg" {
  vpc_id = aws_vpc.vpc_1webseeker.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webseeker_sg"
  }
}

# Public EC2
resource "aws_instance" "public_instance_1webseeker" {
  ami                         = "ami-00d395be40fccc1de"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1webseeker.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.webseeker_sg.id]
  key_name                    = var.key_name

  tags = {
    Name = "public_instance_1webseeker"
  }
}

# Private EC2
resource "aws_instance" "private_instance_1webseeker" {
  ami             = "ami-00d395be40fccc1de"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet_1webseeker.id
  security_groups = [aws_security_group.webseeker_sg.id]
  key_name        = var.key_name

  tags = {
    Name = "private_instance_1webseeker"
  }
}
