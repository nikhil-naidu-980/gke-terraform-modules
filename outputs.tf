
output "cluster_endpoint" {
  value       = module.gke.cluster_endpoint
  description = "GKE cluster endpoint"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}