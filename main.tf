
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