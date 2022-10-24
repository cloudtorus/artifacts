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

resource "digitalocean_kubernetes_cluster" "main" {
  name = "${var.installation}-k8s-cluster"
  region = var.region
  version = "1.24.4-do.0"
  vpc_uuid = data.terraform_remote_state.vpc.outputs.vpc_uuid

  node_pool {
    name = "${var.installation}-k8s-node-pool"
    size = var.k8s_node_pool_size
    node_count = 2
  }
}
