output "pgsql_db_cluster" {
  value = digitalocean_database_cluster.main.id
}

output "pgsql_db_uri" {
  value = "postgresql://${digitalocean_database_user.app.name}:${digitalocean_database_user.app.password}@${digitalocean_database_connection_pool.main.private_host}:${digitalocean_database_connection_pool.main.port}/${digitalocean_database_connection_pool.main.name}"
  sensitive = true
}

output "pgsql_db_ca" {
  value = data.digitalocean_database_ca.main.certificate
  sensitive = true
}
