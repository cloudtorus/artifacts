variable "recipe" {
  type = any
  default = {}
}

data "kubernetes_service" "ghost" {
  metadata {
    name = "ghost"
  }
}
