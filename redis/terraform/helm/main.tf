data "kubernetes_service" "master" {
  metadata {
    name = "redis-master"
  }
}

data "kubernetes_secret" "redis-password" {
  metadata {
    name = "redis-secret"
  }
}
