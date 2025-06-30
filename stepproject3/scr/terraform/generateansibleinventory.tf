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

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content  = <<EOT
[jenkins_master]
${aws_instance.jenkins_master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem

[jenkins_worker]
${aws_instance.jenkins_worker.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/lexan/.ssh/webseeker_key.pem
EOT
}
