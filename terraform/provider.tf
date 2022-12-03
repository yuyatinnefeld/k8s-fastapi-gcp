provider "google" {
  credentials = file("./creds/serviceaccount.json")
  project = var.project_id
  region = var.region
}