output "name" {
  value = google_container_cluster.main.name
}

output "endpoint" {
  value = google_container_cluster.main.endpoint
}

output "region" {
  value = var.region
}
