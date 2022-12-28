terraform {
  backend "gcs" {
    prefix = "terraform/primitives/vpc"
  }
}
