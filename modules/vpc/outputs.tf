# modules/vpc/outputs.tf
output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "ID of the VPC"
}

output "public_subnet_id" {
  value       = google_compute_subnetwork.public_subnet.id
  description = "ID of the public subnet"
}

output "private_subnet_id" {
  value       = google_compute_subnetwork.private_subnet.id
  description = "ID of the private subnet"
}
