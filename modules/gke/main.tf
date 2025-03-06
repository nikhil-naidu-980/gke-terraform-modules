resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.zone
  initial_node_count = 1
  node_config {
    machine_type = var.machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    tags         = ["gke-node"]
    metadata     = { disable-legacy-endpoints = "true" }
  }
  networking_mode = "VPC_NATIVE"
  subnetwork      = var.public_subnet_id
  deletion_protection = false
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }
  network = var.vpc_id
}

resource "google_container_node_pool" "node_pool" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gke.name
  node_count = var.node_count
  node_config {
    machine_type    = var.machine_type
    service_account = var.service_account_email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    tags            = ["gke-node"]
  }
}

output "cluster_endpoint" {
  value = google_container_cluster.gke.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.gke.master_auth[0].cluster_ca_certificate
}

output "node_pool_name" {
  value = google_container_node_pool.node_pool.name
}