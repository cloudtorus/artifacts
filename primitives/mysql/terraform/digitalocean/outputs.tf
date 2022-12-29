output "all" {
  sensitive = true
  value = {
    cluster = digitalocean_database_cluster.main.id
    user     = digitalocean_database_user.app.name
    password = digitalocean_database_user.app.password
    host     = "${var.engine == "pg" ? digitalocean_database_connection_pool.main[0].private_host : digitalocean_database_cluster.main.private_host}"
    port     = "${var.engine == "pg" ? digitalocean_database_connection_pool.main[0].port : digitalocean_database_cluster.main.port}"
    name     = "${var.engine == "pg" ? digitalocean_database_connection_pool.main[0].name : digitalocean_database_db.main.name}"
    uri = "postgresql://${digitalocean_database_user.app.name}:${digitalocean_database_user.app.password}@${
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
    ca = data.digitalocean_database_ca.main.certificate
  }
}
