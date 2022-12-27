resource "helm_release" "app" {
  name  = "ghost"
  chart = "${path.module}/../../helm/ghost"
  timeout = 600
  values = [
    file("${path.module}/../../helm/ghost/values.yaml")
  ]

  set {
    name = "database.user"
    value = var.database.user
  }
  set {
    name = "database.password"
    value = var.database.password
  }
  set {
    name = "database.host"
    value = var.database.host
  }
  set {
    name = "database.port"
    value = var.database.port
  }
  set {
    name = "database.name"
    value = var.database.name
  }
  set {
    name = "database.ssl.ca"
    value = var.database.ssl.ca
  }
}
