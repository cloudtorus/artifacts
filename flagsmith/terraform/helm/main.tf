resource "helm_release" "app" {
  name = "flagsmith"
  chart = "${path.module}/../../helm/flagsmith"
  timeout = 600
  values = [
    file("${path.module}/../../helm/flagsmith/values.yaml")
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
