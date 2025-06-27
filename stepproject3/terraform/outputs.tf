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
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "ID приватной подсети — размещение Jenkins Worker"
  value       = module.network.private_subnet_id
}

output "webserver_sg_id" {
  description = "ID Security Group, разрешающей SSH и HTTP"
  value       = aws_security_group.webserver_sg.id
}
