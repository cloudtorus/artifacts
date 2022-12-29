data "kubernetes_service" "ghost" {
  metadata {
    name = "ghost"
  }
}
