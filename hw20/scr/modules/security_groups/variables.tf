variable "vpc_id" {
  description = "id of vpc"
  type        = string
}
variable "list_of_open_ports" {
  description = "Список портов, которые нужно открыть"
  type        = list(number)
}
