resource "digitalocean_spaces_bucket" "terraform" {
  name = var.storage_bucket
  force_destroy = false
  region = "nyc3"
}
