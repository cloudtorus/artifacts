output "all" {
  sensitive = true
  value = {
    id       = google_sql_database_instance.main.id
    user     = google_sql_user.main.name
    password = google_sql_user.main.password
    host     = google_sql_database_instance.main.private_ip_address
    port     = 5432
    name     = google_sql_database.main.name
    uri      = "postgres://${google_sql_user.main.name}:${google_sql_user.main.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.main.name}"
    ca       = google_sql_database_instance.main.server_ca_cert.0.cert
  }
}
