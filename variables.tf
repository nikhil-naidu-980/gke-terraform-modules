variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-west1"
}

variable "zone" {
  type        = string
  description = "GCP zone"
  default     = "us-west1-a"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "gke-vpc"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR range for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR range for the private subnet"
  default     = "10.0.2.0/24"
}

variable "service_account_id" {
  type        = string
  description = "ID for the GKE service account"
  default     = "gke-service-account"
}