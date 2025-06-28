output "jenkins_master_public_ip" {
  value = aws_instance.public_instance_1webseeker.public_ip
}

output "jenkins_worker_private_ip" {
  value = aws_instance.private_instance_1webseeker.private_ip
}
