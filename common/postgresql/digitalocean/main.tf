data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    endpoint = "https://${var.region}.digitaloceanspaces.com"
    region = "us-east-1"
    bucket = var.backend_bucket
    key = "vpc.terraform.tfstate"
    access_key = var.spaces_access_id
    secret_key = var.spaces_secret_key
    skip_credentials_validation = true
    skip_region_validation = true
  }
}

resource "digitalocean_database_cluster" "main" {
  name = "${var.installation}-db-cluster"
  engine = "pg"
  version = "11"
  size = "db-s-1vcpu-1gb"
  region = var.region
  node_count = 1
  private_network_uuid = data.terraform_remote_state.vpc.outputs.vpc_uuid
}

resource "digitalocean_database_db" "main" {
  cluster_id = digitalocean_database_cluster.main.id
  name    = "${var.installation}-db"
}

resource "digitalocean_database_connection_pool" "main" {
  cluster_id = digitalocean_database_cluster.main.id
  name = "${var.installation}-db-conn-pool"
  mode = "transaction"
  size = 20
  db_name = digitalocean_database_cluster.main.name
  user = "app"
}

resource "digitalocean_database_user" "app" {
  cluster_id = digitalocean_database_cluster.main.id
  name = "app"
}
