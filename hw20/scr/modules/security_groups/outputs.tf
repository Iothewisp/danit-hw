output "id_of_security_group" {
  description = "Created id of security group"
  value       = aws_security_group.web_sg.id
}
