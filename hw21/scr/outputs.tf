output "public_ips" {
 description = "Список публичных IP-адресов созданных инстансов"
  value       = aws_instance.web[*].public_ip
}
output "security_group_id" {
  description = "ID Security Group"
  value       = aws_security_group.webserver_sg.id
}
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible_inventory"
  content  = <<EOT
[webservers]
%{ for ip in aws_instance.web[*].public_ip ~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/webseeker_key.pem
%{ endfor ~}
EOT
}


#resource "local_file" "example" {
#content = "Hello, Terraform!"
#filename = "${path.module}/example.txt"
#}

# echo "[webservers]" > ansible_inventory
# terraform output public_ips | ForEach-Object { "$_ ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/webseeker_key.pem" } >> ansible_inventory

#ansible -i ansible_inventory all --list-hosts -VVV   
#ansible -i ansible_inventory all --list-hosts 

#https://hub.docker.com/_/nginx

#echo "[webservers]" > ansible_inventory
#echo "18.199.165.169 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/webseeker_key.pem" >> ansible_inventory
#echo "63.177.70.37 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/webseeker_key.pem" >> ansible_inventory