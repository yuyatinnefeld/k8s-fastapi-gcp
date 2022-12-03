resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name             = var.db_instance_name
  region           = var.region
  database_version = "POSTGRES_14"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_name
    }
  }
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  host     = "me.com"
  password = var.db_password
}


resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}