
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

provider "kubernetes" {
  host                   = module.gke.cluster_endpoint
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

module "nginx_app" {
  source         = "./modules/nginx_app"
  namespace_name = var.namespace_name
  app_name       = var.app_name
  node_pool_name = module.gke.node_pool_name
  replicas       = var.replicas
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  nginx_service_name = module.nginx_app.service_name
  nginx_namespace    = module.nginx_app.namespace
  domain             = var.domain
  region             = var.region
}