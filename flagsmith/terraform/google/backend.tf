terraform {
  backend "gcs" {
    prefix = "terraform/flagsmith"
  }
}
