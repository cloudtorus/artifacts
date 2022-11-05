output "id" {
  value = google_sql_database_instance.main.id
}

output "user" {
  value = google_sql_user.main.name
}

output "password" {
  value = google_sql_user.main.password
  sensitive = true
}

output "host" {
  value = google_sql_database_instance.main.private_ip_address
}

output "port" {
  value = var.engine == "pg" ? 5432 : 3306
}

output "name" {
  value = google_sql_database.main.name
}

output "uri" {
  value = "${engine == "pg" ? "postgres" : "mysql"}://${google_sql_user.main.name}:${google_sql_user.main.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.main.name}"
  sensitive = true
}

output "ca" {
  value = google_sql_database_instance.main.server_ca_cert.0.cert
  sensitive = true
}
