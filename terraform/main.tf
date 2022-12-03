locals {
  env = var.env
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.0.0"
    }
  }
}

module "cloud_sql" {
  source                = "./modules/cloud_sql"
  region                = var.region
  db_instance_name      = var.db_instance_name
  network_name          = var.network_name
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  db_instance_name      = var.db_instance_name
}