data "kubernetes_service" "metabase" {
  metadata {
    name = "metabase"
  }
}
