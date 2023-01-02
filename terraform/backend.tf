terraform {
  backend "gcs" {
    bucket      = "yuyatinnefeld-ENVIRONMENT-tf-state"
    prefix      = "state/test"
  }
}
