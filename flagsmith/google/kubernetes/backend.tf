terraform {
  backend "gcs" {
    prefix = "terraform/state/flagsmith-kubernetes"
  }
}
