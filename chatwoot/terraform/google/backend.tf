terraform {
  backend "gcs" {
    prefix = "terraform/chatwoot"
  }
}
