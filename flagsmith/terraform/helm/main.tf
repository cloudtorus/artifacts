resource "helm_release" "app" {
  name = "flagsmith"
  chart = var.helm_release.chart
  timeout = 600
  values = [var.helm_release.values]

  set {
    name = "flagsmith.postgresql.connection_uri"
    value = var.database_uri
  }
  set {
    name  = "flagsmith.postgresql.connection_ca"
    value = var.database_ca
  }
}
