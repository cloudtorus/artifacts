resource "digitalocean_kubernetes_cluster" "main" {
  name = "${var.installation}-k8s-cluster"
  region = var.region
  version = "1.24.4-do.0"

  node_pool {
    name = "${var.installation}-k8s-node-pool"
    size = var.k8s_node_pool_size
    node_count = 2
  }
}

resource "digitalocean_kubernetes_node_pool" "medium" {
  cluster_id = digitalocean_kubernetes_cluster.main.id
  name = "${var.installation}-md"
  size = "g-2cpu-8gb"
  min_nodes = 0
  max_nodes = 9
  auto_scale = true
}
