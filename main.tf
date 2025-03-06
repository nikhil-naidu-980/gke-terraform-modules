
provider "google" {
  region  = var.region
  project = var.project_id
}

data "google_client_config" "default" {}

module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = var.vpc_name
  region         = var.region
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "service_account" {
  source            = "./modules/service_account"
  project_id        = var.project_id
  service_account_id = var.service_account_id
}

module "gke" {
  source              = "./modules/gke"
  cluster_name        = var.cluster_name
  region              = var.region
  zone                = var.zone
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnet_id
  service_account_email = module.service_account.service_account_email
  machine_type        = var.machine_type
  node_count          = var.node_count
}