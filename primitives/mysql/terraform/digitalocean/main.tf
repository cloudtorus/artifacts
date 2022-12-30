resource "digitalocean_database_cluster" "main" {
  name       = "torus-${var.context.id}"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = var.context.region
  node_count = 1
}

resource "digitalocean_database_user" "app" {
  cluster_id = digitalocean_database_cluster.main.id
  name       = "app"
}

data "digitalocean_database_ca" "main" {
  cluster_id = digitalocean_database_cluster.main.id
}
