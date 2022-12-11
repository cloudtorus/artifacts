terraform {
  backend "gcs" {
    prefix = "terraform/metabase"
  }
}
