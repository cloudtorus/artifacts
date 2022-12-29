output "all" {
  sensitive = true
  value = {
    cluster = digitalocean_database_cluster.main.id
    user     = digitalocean_database_user.app.name
    password = digitalocean_database_user.app.password
    host     = "${digitalocean_database_cluster.main.private_host}"
    port     = "${digitalocean_database_cluster.main.port}"
    name     = "${digitalocean_database_db.main.name}"
    uri = "postgresql://${digitalocean_database_user.app.name}:${digitalocean_database_user.app.password}@${ :
      digitalocean_database_cluster.main.host
    }:${digitalocean_database_cluster.main.port}/${
      digitalocean_database_db.main.name
    }"
    ca = data.digitalocean_database_ca.main.certificate
  }
}
