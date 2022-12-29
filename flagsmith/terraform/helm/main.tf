data "kubernetes_service" "flagsmith" {
  metadata {
    name = "flagsmith"
  }
}
