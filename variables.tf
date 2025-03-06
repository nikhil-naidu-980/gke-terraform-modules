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

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "my-gke-cluster"
}

variable "machine_type" {
  type        = string
  description = "Machine type for GKE nodes"
  default     = "e2-medium"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the GKE node pool"
  default     = 1
}

variable "namespace_name" {
  type        = string
  description = "Kubernetes namespace for the NGINX app"
  default     = "nginx-app-namespace"
}

variable "app_name" {
  type        = string
  description = "Name of the NGINX app"
  default     = "nginx-app"
}

variable "replicas" {
  type        = number
  description = "Number of NGINX replicas"
  default     = 1
}