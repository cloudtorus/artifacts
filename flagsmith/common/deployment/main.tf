resource "helm_release" "app" {
  name = "flagsmith"
  chart = "${path.module}/chart"

  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name = "postgresql.connection_uri"
    value = var.database_uri
  }
  set {
    name  = "postgresql.connection_ca"
    value = var.database_ca
  }
}
