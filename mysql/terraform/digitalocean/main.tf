resource "kubernetes_namespace" "mysql" {
  metadata {
    name = var.context.id
  }
}
