resource "google_storage_bucket" "gcs_buckets" {
  for_each = {
    "app_bucket"        = "app"
    "data_bucket"       = "data"
    "backup_bucket"     = "backup"
    "staging_bucket"    = "staging"
  }

  name                        = "yuya-${var.env}-${each.value}"
  location                    = var.region
  uniform_bucket_level_access = true
  labels = {
    created = "terraform"
  }
}