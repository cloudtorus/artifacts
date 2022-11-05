output "pgsql_db_cluster" {
  value = digitalocean_database_cluster.main.id
}

output "user" {
  value = digitalocean_database_user.app.name
}

output "password" {
  value = digitalocean_database_user.app.password
  sensitive = true
}

output "host" {
  value = "${var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].private_host :
    digitalocean_database_cluster.main.private_host}"
}

output "port" {
  value = "${var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].port :
    digitalocean_database_cluster.main.port}"
}

output "name" {
  value = "${var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].name :
    digitalocean_database_db.main.name}"
}

output "pgsql_db_uri" {
  value = "postgresql://${digitalocean_database_user.app.name}:${digitalocean_database_user.app.password}@${
    var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].host :
    digitalocean_database_cluster.main.host}:${
    var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].port :
    digitalocean_database_cluster.main.port}/${
    var.engine == "pg" ?
    digitalocean_database_connection_pool.main[0].name :
    digitalocean_database_db.main.name
    }"
  sensitive = true
}

output "pgsql_db_ca" {
  value = data.digitalocean_database_ca.main.certificate
  sensitive = true
}
