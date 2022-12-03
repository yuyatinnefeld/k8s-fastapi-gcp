resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name             = "my-postgresql-instance"
  region           = var.region
  database_version = "POSTGRES_14"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = "projects/yuyatinnefeld-dev/global/networks/vpc-mainnet"
    }
  }
}

resource "google_sql_user" "users" {
  name     = "postgres"
  instance = google_sql_database_instance.instance.name
  host     = "me.com"
  password = "password"
}


resource "google_sql_database" "database" {
  name     = "sample-db"
  instance = google_sql_database_instance.instance.name
}