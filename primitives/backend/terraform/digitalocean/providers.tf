terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.token
  spaces_access_id = var.backend.access_key
  spaces_secret_key = var.backend.secret_key
}
