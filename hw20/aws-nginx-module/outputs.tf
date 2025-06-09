output "instance_ip" {
  description = "IP созданного EC2-инстанса"
  value       = aws_instance.nginx.public_ip
}
