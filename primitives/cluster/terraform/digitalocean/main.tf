resource "digitalocean_kubernetes_cluster" "main" {
  name    = "torus-${var.context.id}"
  region  = var.context.region
  version = "1.24.8-do.0"

  node_pool {
    name       = "torus-${var.context.id}-node-pool"
    size       = var.k8s_node_pool_size
    node_count = 2
  }
}
