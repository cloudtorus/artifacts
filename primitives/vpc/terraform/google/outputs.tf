output "all" {
  value = {
    vpc_id = google_compute_network.main.id
    vpc_name = google_compute_network.main.name
    subnet_id = google_compute_subnetwork.main.id
    subnet_name = google_compute_subnetwork.main.name
  }
}
