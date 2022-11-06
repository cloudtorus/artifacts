terraform {
  backend "gcs" {
    prefix = "terraform/ghost"
  }
}
