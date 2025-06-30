
variable "ami_id" {
  description = "ID Amazon Machine Image для EC2-инстанса"
  default     = "ami-0ef7e778d25af6645"  # Ubuntu 22.04 в eu-central-1
}
variable "instance_type" {
  description = "Тип EC2-инстанса, например t2.micro или t3.small"
  default     = "t2.micro"
}

