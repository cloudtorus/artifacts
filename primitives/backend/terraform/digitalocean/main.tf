resource "digitalocean_spaces_bucket" "terraform" {
  name          = var.backend.bucket
  force_destroy = false
  region        = "nyc3"
}
