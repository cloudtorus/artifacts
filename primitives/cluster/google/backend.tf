terraform {
  backend "gcs" {
    prefix = "terraform/primitives/cluster"
  }
}
