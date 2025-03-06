
variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "node_count" {
  type = number
}