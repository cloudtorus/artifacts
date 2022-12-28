output "vpc_id" {
  value = google_compute_network.main.id
}

output "subnet_id" {
  value = google_compute_subnetwork.main.id
}

output "vpc_name" {
  value = google_compute_network.main.name
}

output "subnet_name" {
  value = google_compute_subnetwork.main.name
}
