# 🛡 Security Group для Web-серверов (на память)
# resource "aws_security_group" "webserver_sg" {
#   name        = "webseekersecure.sg"
#   description = "Security group for webservers"
#   vpc_id      = aws_vpc.main.id 
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "webseekersSG"
#   }
# }


# ✅ Новый блок SG для Jenkins Master и Worker
resource "aws_security_group" "webserver_sg" {
  name        = "webseekersecure.sg"
  description = "Security group for Jenkins Master and Worker"
  vpc_id      = aws_vpc.main.id 

  # 👨‍💻 Разрешаем SSH-доступ снаружи
  ingress {
    description = "SSH from internet (Master only)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 🌐 HTTP-доступ (если ты раздаёшь nginx на 80 порту)
  ingress {
    description = "HTTP access (port 80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 🔧 Новый! Для Jenkins Web UI на порту 8080
  ingress {
    description = "Jenkins Web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 🚀 Разрешаем все исходящие соединения (по умолчанию)
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webseekersSG"
  }
}

# 🔄 SSH-соединения между Jenkins Master и Worker (оба в одной SG)
resource "aws_security_group_rule" "allow_ssh_between_master_and_worker" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.webserver_sg.id
  source_security_group_id = aws_security_group.webserver_sg.id
  description              = "SSH Master to Worker (same SG)"
}
