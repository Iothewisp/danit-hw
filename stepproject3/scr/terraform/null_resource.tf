# Фитча тест автопут pem ключа в мастер для Linux 
resource "null_resource" "copy_ssh_key_to_master" {
  provisioner "file" {
    source      = "/home/lexan/.ssh/webseeker_key.pem"
    destination = "/home/ubuntu/webseeker_key.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.jenkins_master.public_ip
      private_key = file("/home/lexan/.ssh/webseeker_key.pem")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/webseeker_key.pem",
      "mkdir -p ~/.ssh && mv /home/ubuntu/webseeker_key.pem ~/.ssh/"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.jenkins_master.public_ip
      private_key = file("/home/lexan/.ssh/webseeker_key.pem")
    }
  }

  depends_on = [aws_instance.jenkins_master]
}