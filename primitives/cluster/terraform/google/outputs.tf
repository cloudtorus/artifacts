output "all" {
  value = {
    name = google_container_cluster.main.name
    endpoint = google_container_cluster.main.endpoint
  }
}
