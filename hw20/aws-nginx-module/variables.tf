variable "key_name" {
  description = "Имя SSH-ключа для EC2"
  type        = string
  default     = "webseeker_key"
}
variable "list_of_open_ports" {
  description = "Список портов, которые нужно открыть"
  type        = list(number)
  default     = [22, 80, 443]
}
