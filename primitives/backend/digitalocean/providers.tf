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
  spaces_access_id = var.spaces_access_id
  spaces_secret_key = var.spaces_secret_key
}