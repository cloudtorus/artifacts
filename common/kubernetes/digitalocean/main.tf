resource "digitalocean_kubernetes_cluster" "main" {
  name = "${var.installation}-k8s-cluster"
  region = var.region
  version = "1.24.4-do.0"

  node_pool {
    name = "${var.installation}-k8s-node-pool"
    size = var.k8s_node_pool_size
    node_count = 1
  }
}
