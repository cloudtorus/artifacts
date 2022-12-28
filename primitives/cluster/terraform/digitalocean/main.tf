resource "digitalocean_kubernetes_cluster" "main" {
  name = "${var.context.id}-cluster"
  region = var.context.region
  version = "1.25.4-do.0"

  node_pool {
    name = "${var.context.id}-cluster-node-pool"
    size = var.k8s_node_pool_size
    node_count = 2
  }
}
