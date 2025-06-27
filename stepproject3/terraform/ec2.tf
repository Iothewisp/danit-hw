# 🔐 Jenkins Master (в публичной подсети)
resource "aws_instance" "jenkins_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.network.public_subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]

  tags = {
    Name        = "Jenkins-Master"
    Environment = "DevOps"
    Role        = "Jenkins"
    Owner       = "Webseeker"
  }
}

# 🤖 Jenkins Worker (в приватной подсети, Spot-инстанс)
resource "aws_instance" "jenkins_worker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.network.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  instance_market_options {
    market_type = "spot"
  }

  tags = {
    Name        = "Jenkins-Worker"
    Environment = "DevOps"
    Role        = "Worker"
    Owner       = "Webseeker"
  }
}
