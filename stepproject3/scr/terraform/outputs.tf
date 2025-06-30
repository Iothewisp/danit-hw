output "jenkins_master_public_ip" {
  description = "Публичный IP Jenkins Master — используется для SSH и веб-доступа"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_master_instance_id" {
  description = "ID EC2-инстанса Jenkins Master"
  value       = aws_instance.jenkins_master.id
}

output "jenkins_master_instance_type" {
  description = "Тип инстанса Jenkins Master (например, t2.micro)"
  value       = aws_instance.jenkins_master.instance_type
}

output "jenkins_master_name_tag" {
  description = "Значение тега Name EC2-инстанса Jenkins Master"
  value       = aws_instance.jenkins_master.tags["Name"]
}

output "jenkins_worker_private_ip" {
  description = "Приватный IP Jenkins Worker — используется внутри VPC и для Ansible"
  value       = aws_instance.jenkins_worker.private_ip
}

output "jenkins_inventory" {
  description = "Готовый блок inventory для Ansible"
  value = <<EOT
[master]
${aws_instance.jenkins_master.public_ip}

[worker]
${aws_instance.jenkins_worker.private_ip}
EOT
}

output "public_subnet_id" {
  description = "ID публичной подсети — размещение Jenkins Master"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID приватной подсети — размещение Jenkins Worker"
  value       = aws_subnet.private.id
}

output "webserver_sg_id" {
  description = "ID Security Group, разрешающей SSH и HTTP"
  value       = aws_security_group.webserver_sg.id
}
# SSH SSH SSH :D TEXNOLODJA!
# output "jenkins_master_ssh_command" {
#   description = "Новій мой SSH к Jenkins Master V4.3"
#   value = "ssh -i \"C:\\Users\\lexan\\.ssh\\webseeker_key.pem\" ubuntu@${aws_instance.jenkins_master.public_ip}"
# }

# output "jenkins_worker_ssh_command" {
#   description = "SSH к Jenkins Worker (через май Jenkins Master по Jump Host аутоматизейша)"
#   value = "ssh -i \"C:\\Users\\lexan\\.ssh\\webseeker_key.pem\" -J ubuntu@${aws_instance.jenkins_master.public_ip} ubuntu@${aws_instance.jenkins_worker.private_ip}"
# }

# SSH SSH SSH :D TEXNOLODJA!
output "jenkins_ssh_commands" {
  description = "SSH команды для Jenkins Master и Worker (убрать ЭКРАН  єту штуку \\\\\\ убрать   )"
  value = {
    master = "ssh -i \"C:/Users/lexan/.ssh/webseeker_key.pem\" ubuntu@${aws_instance.jenkins_master.public_ip}"
    worker = "ssh -i \"C:/Users/lexan/.ssh/webseeker_key.pem\" -J ubuntu@${aws_instance.jenkins_master.public_ip} ubuntu@${aws_instance.jenkins_worker.private_ip}"
  }
}
# # # фитча тест автопут pem ключа в мастер для винді коммент
# resource "null_resource" "copy_ssh_key_to_master" {
#   provisioner "file" {
#     source      = "C:/Users/lexan/.ssh/webseeker_key.pem"
#     destination = "/home/ubuntu/webseeker_key.pem"

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host        = aws_instance.jenkins_master.public_ip
#       private_key = file("C:/Users/lexan/.ssh/webseeker_key.pem")
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod 400 /home/ubuntu/webseeker_key.pem",
#       "mkdir -p ~/.ssh && mv /home/ubuntu/webseeker_key.pem ~/.ssh/"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host        = aws_instance.jenkins_master.public_ip
#       private_key = file("C:/Users/lexan/.ssh/webseeker_key.pem")
#     }
#   }

#   depends_on = [aws_instance.jenkins_master]
# }


# Фитча тест автопут pem ключа в мастер для Linux 
# resource "null_resource" "copy_ssh_key_to_master" {
#   provisioner "file" {
#     source      = "/home/lexan/.ssh/webseeker_key.pem"
#     destination = "/home/ubuntu/webseeker_key.pem"

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host        = aws_instance.jenkins_master.public_ip
#       private_key = file("/home/lexan/.ssh/webseeker_key.pem")
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod 400 /home/ubuntu/webseeker_key.pem",
#       "mkdir -p ~/.ssh && mv /home/ubuntu/webseeker_key.pem ~/.ssh/"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host        = aws_instance.jenkins_master.public_ip
#       private_key = file("/home/lexan/.ssh/webseeker_key.pem")
#     }
#   }

#   depends_on = [aws_instance.jenkins_master]
# }


# # Аутоматизайшон Технолоджиа передачи айпи инстаносов сразу в playbook Ansible
# resource "local_file" "ansible_inventory" {
#   filename = "${path.module}/../ansible/inventory.ini"
#   content  = <<EOT
# [jenkins_master]
# ${aws_instance.jenkins_master.public_ip} ansible_user=webseeker ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem

# [jenkins_worker]
# ${aws_instance.jenkins_worker.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem
# EOT
# }

# # Этот блок создает inventory для Ansible с IP-адресами Jenkins Master и Worker

# resource "local_file" "ansible_inventory" {
#   filename = "${path.module}/../ansible/inventory.ini"
#   content  = <<EOT
# [jenkins_master]
# ${aws_instance.jenkins_master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem

# [jenkins_worker]
# ${aws_instance.jenkins_worker.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem
# EOT
# }























# output "jenkins_inventory" {
#   description = "Готовый inventory для Ansible"
#   value = <<EOT
# [jenkins_master]
# ${aws_instance.jenkins_master.public_ip}

# [jenkins_worker]
# ${aws_instance.jenkins_worker.private_ip}
# EOT
# }
