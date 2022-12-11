resource "google_compute_network" "main" {
  name = "${var.installation}-torus-vpc"
  project = var.project
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  name = "${var.installation}-torus-subnet"
  region = var.region
  network = google_compute_network.main.name
  ip_cidr_range = "10.0.0.0/24"
  project = var.project
}
