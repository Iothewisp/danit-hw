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