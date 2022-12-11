resource "digitalocean_database_cluster" "main" {
  name = "${var.installation}-db-cluster"
  engine = var.engine
  version = var.engine == "pg" ? "11" : "8"
  size = "db-s-1vcpu-1gb"
  region = var.region
  node_count = 1
}

resource "digitalocean_database_db" "main" {
  cluster_id = digitalocean_database_cluster.main.id
  name    = "${var.installation}-db"
}

resource "digitalocean_database_user" "app" {
  cluster_id = digitalocean_database_cluster.main.id
  name = "app"
}

data "digitalocean_database_ca" "main" {
  cluster_id = digitalocean_database_cluster.main.id
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [digitalocean_database_db.main]
  create_duration = "30s"
}

resource "digitalocean_database_connection_pool" "main" {
  cluster_id = digitalocean_database_cluster.main.id
  name = "${var.installation}-db-conn-pool"
  mode = "transaction"
  size = 20
  db_name = digitalocean_database_db.main.name
  user = "app"
  count = var.engine == "pg" ? 1 : 0
  depends_on = [digitalocean_database_db.main, time_sleep.wait_30_seconds]
}
