resource "digitalocean_vpc" "main" {
  name   = "${var.installation}-vpc"
  region = "nyc3"
  ip_range = "10.10.10.0/24"
}
