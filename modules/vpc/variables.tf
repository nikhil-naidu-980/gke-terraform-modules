# modules/vpc/variables.tf
variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR range for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR range for the private subnet"
}
