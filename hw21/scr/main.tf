provider "aws" {
  region = "eu-central-1"
}
# 🏗 Создание VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "webseekersVPC"
  }
}
# # 🏗 Создание VPC
# resource "aws_vpc" "main_vpc" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "webseekersVPC"
#   }
# }

# 🌐 Публичная Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true  

  tags = {
    Name = "webseekers-public-subnet"
  }
}

# 🚀 Интернет-шлюз (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "webseekervpc-igw"
  }
}

# 🛣 Route Table для выхода в интернет
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "webseekervpc-public-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id  # ✅ Исправленная ссылка
}

# 🔗 Ассоциация Route Table с публичной Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 🛡 Security Group для Web-серверов
resource "aws_security_group" "webserver_sg" {
  name        = "webseekersecure.sg"
  description = "Security group for webservers"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔥 SSH доступ (лучше указать свой IP)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔥 Открытый доступ к Nginx
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 🔥 Разрешить выход в интернет
  }

  tags = {
    Name = "webseekersSG"
  }
}

# 🚀 Web-серверы на EC2
resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-011638ac956d98da4"
  instance_type = "t2.micro"
  key_name      = "webseeker_key"

  subnet_id                 = aws_subnet.public_subnet.id
  vpc_security_group_ids    = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "WebServer-${count.index}"
  }

  # 📄 Генерация инвентаря для Ansible (исправленный `local-exec`)
  provisioner "local-exec" {
    command = <<EOT
      echo "[webservers]" > ansible_inventory
      terraform output public_ips | awk '{print $1, "ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/webseeker_key.pem"}' >> ansible_inventory
    EOT
  }
}

