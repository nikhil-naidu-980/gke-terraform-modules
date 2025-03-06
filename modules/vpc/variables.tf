# modules/vpc/variables.tf
variable "vpc_name" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}