data "kubernetes_service" "chatwoot" {
  metadata {
    name = "chatwoot"
  }
  depends_on = [helm_release.chatwoot]
}
