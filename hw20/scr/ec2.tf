resource "aws_instance" "nginx" {
  ami                    = "ami-0090963cc60d485c3"  
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [module.security_group.id_of_security_group]
  key_name               = var.key_name  
  user_data = <<EOF
#!/bin/bash
    sudo su
    amazon-linux-extras install nginx1
    systemctl enable nginx
    systemctl start nginx
EOF

  tags = {
    Name = "webseekervpc-nginx"
  }
}
