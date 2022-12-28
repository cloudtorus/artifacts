data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/primitives/vpc"
    credentials = var.credentials
  }
}

resource "google_container_cluster" "main" {
  name = "${var.installation}-torus-cluster"
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  network = data.terraform_remote_state.vpc.outputs.vpc_name
  subnetwork = data.terraform_remote_state.vpc.outputs.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name = ""
    services_secondary_range_name = ""
  }
}

resource "google_container_node_pool" "main" {
  name = google_container_cluster.main.name
  location = var.region
  cluster = google_container_cluster.main.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project
    }

    machine_type = "n1-standard-1"
    tags = ["gke-node", "${var.installation}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
