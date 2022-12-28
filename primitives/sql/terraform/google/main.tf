data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/primitives/vpc"
    credentials = var.credentials
  }
}

resource "google_compute_global_address" "db_ip" {
  name = "${var.installation}-sql-ip"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 24
  network = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "google_service_networking_connection" "db_conn" {
  network = data.terraform_remote_state.vpc.outputs.vpc_id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.db_ip.name]
}

resource "google_sql_database_instance" "main" {
  name = "${var.installation}-db-instance"
  project = var.project
  region = var.region
  database_version = var.engine == "pg" ? "POSTGRES_11" : "MYSQL_8"
  depends_on = [google_service_networking_connection.db_conn]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      private_network = data.terraform_remote_state.vpc.outputs.vpc_id
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "main" {
  name = "${var.installation}-db"
  instance = google_sql_database_instance.main.name
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
