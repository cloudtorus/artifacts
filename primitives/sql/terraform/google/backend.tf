terraform {
  backend "gcs" {
    prefix = "terraform/primitives/sql"
  }
}
