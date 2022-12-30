resource "google_compute_global_address" "db_ip" {
  name          = "torus-${var.context.id}-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.dependencies.vpc.vpc_id
}

resource "google_service_networking_connection" "db_conn" {
  network                 = var.dependencies.vpc.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.db_ip.name]
}

resource "google_sql_database_instance" "main" {
  name             = "torus-${var.context.id}"
  project          = var.context.project
  region           = var.context.region
  database_version = "POSTGRES_11"
  depends_on       = [google_service_networking_connection.db_conn]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      private_network = var.dependencies.vpc.vpc_id
    }
  }

  deletion_protection = false
}

resource "random_password" "main" {
  length  = 32
  special = false
}

resource "google_sql_user" "main" {
  deletion_policy = "ABANDON"
  name            = "app"
  instance        = google_sql_database_instance.main.name
  password        = random_password.main.result
}
