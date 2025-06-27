variable "name_prefix" {
  type        = string
  description = "Prefix for resource names and tags"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  default     = "10.0.2.0/24"
}

variable "create_vpc" {
  type    = bool
  default = true
}
