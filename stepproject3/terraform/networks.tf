# 🏗 VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  # enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "webseeker-vpc"
    # Environment = "DevOpsLab"
    # Owner       = "Webseeker"
  }
}

# 🌐 Публичная подсеть
resource "aws_subnet" "public" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "webseeker-subnet-public"
  }
}

# 🔒 Приватная подсеть
resource "aws_subnet" "private" {
  cidr_block = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "webseeker-subnet-private"
  }
}

# 🚀 Интернет-шлюз
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "webseeker-igw"
  }
}

# # 🌍 Elastic IP для NAT
# resource "aws_eip" "nat" {
#    domain = "vpc"

#   tags = {
#     Name = "webseeker-nat-eip"
#   }
# }

# NAT Gateway
resource "aws_eip" "nateip" {
  domain = "vpc"
  tags = {
    Name = "nat_eip_1webseeker"
  }
}
# 🔁 NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "webseeker-nat"
  }
}

# 🛣 Публичная таблица маршрутов
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.igw.id
  }
  tags = {
    Name = "webseeker-rt-public"
  }
}

# # 🚦 Путь из публичной подсети в интернет
# # resource "aws_route" "internet_access" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# 🔗 Ассоциация публичной подсети
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 🛣 Приватная таблица маршрутов
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "webseeker-rt-private"
  }
}

# 🚦 Приватный маршрут через NAT
# resource "aws_route" "private_to_nat" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# 🔗 Ассоциация приватной подсети
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
