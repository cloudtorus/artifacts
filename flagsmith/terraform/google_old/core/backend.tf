terraform {
  backend "gcs" {
    prefix = "terraform/state/flagsmith/core"
  }
}
