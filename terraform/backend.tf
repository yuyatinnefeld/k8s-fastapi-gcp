terraform {
  backend "gcs" {
    bucket      = "yuyatinnefeld-ENVIRONMENT-tf-state"
    prefix      = "state/resources"
    credentials = "./creds/serviceaccount.json"
  }
}
