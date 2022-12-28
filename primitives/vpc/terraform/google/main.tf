resource "google_compute_network" "main" {
  name = "${var.context.id}-torus-vpc"
  project = var.context.project
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  name = "${var.context.id}-torus-subnet"
  region = var.context.region
  network = google_compute_network.main.name
  ip_cidr_range = "10.0.0.0/24"
  project = var.context.project
}
