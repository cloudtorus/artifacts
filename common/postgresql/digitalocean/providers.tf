terraform {
  required_providers {
    digitalocean = {
      source = "hashicorp/digitalocean"
    }
  }
}

provider "digitalocean" {
  token = var.token
}
