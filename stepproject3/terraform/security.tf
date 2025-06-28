# 🛡 Security Group для Web-серверов
resource "aws_security_group" "webserver_sg" {
  name        = "webseekersecure.sg"
  description = "Security group for webservers"
  vpc_id      = aws_vpc.main.id 

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
