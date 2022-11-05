# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.installation}-flagsmith-vpc"
  project                 = var.project
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.installation}-flagsmith-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
  project = var.project
}

# Database
resource "google_compute_global_address" "database_ip_address" {
  name          = "${var.installation}-flagsmith-vpc-db"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vpc.id
}
resource "google_service_networking_connection" "database_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.database_ip_address.name]
}
resource "google_sql_database_instance" "main" {
  name             = "${var.installation}-flagsmith-db"
  project          = var.project
  region           = var.region
  database_version = "POSTGRES_11"
  depends_on       = [google_service_networking_connection.database_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      private_network = google_compute_network.vpc.id
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "primary" {
  name     = "${var.installation}-flagsmith-db"
  instance = google_sql_database_instance.main.name
}

# Kubernetes
resource "google_container_cluster" "primary" {
  name     = "${var.installation}-flagsmith"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_secondary_range_name  = ""
    services_secondary_range_name = ""
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
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
    tags         = ["gke-node", "${var.installation}-gke"]
    metadata     = {
      disable-legacy-endpoints = "true"
    }
  }
}

resource "random_password" "flagsmith_db_password" {
  length  = 32
  special = false
}

resource "google_sql_user" "flagsmith_db_user" {
  deletion_policy = "ABANDON"
  name            = "flagsmith"
  instance        = google_sql_database_instance.main.name
  password        = random_password.flagsmith_db_password.result
}
