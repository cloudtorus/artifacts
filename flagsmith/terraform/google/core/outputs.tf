output "project" {
  value = var.project
}

output "region" {
  value = var.region
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_host" {
  value = google_container_cluster.primary.endpoint
}

output "database_connection" {
  value = "postgresql://${google_sql_user.flagsmith_db_user.name}:${google_sql_user.flagsmith_db_user.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.primary.name}"
  sensitive = true
}
