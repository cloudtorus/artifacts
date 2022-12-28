resource "google_container_cluster" "main" {
  name = "${var.context.id}-torus-cluster"
  location = var.context.region
  remove_default_node_pool = true
  initial_node_count = 1
  network = var.dependencies.vpc.vpc_id
  subnetwork = var.dependencies.vpc.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name = ""
    services_secondary_range_name = ""
  }
}

resource "google_container_node_pool" "main" {
  name = google_container_cluster.main.name
  location = var.context.region
  cluster = google_container_cluster.main.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.context.project
    }

    machine_type = "n1-standard-1"
    tags = ["gke-node", "${var.context.id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
