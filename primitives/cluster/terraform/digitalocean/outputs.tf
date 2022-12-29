output "all" {
  sensitive = true
  value = {
    name     = digitalocean_kubernetes_cluster.main.name
    endpoint = digitalocean_kubernetes_cluster.main.endpoint
    region   = digitalocean_kubernetes_cluster.main.region
  }
}
