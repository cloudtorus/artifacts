resource "random_password" "redis" {
  length = 32
  special = false
  numeric = false
}

resource "helm_release" "app" {
  chart = "${path.module}/../../helm/redis"
  name = "redis"
  timeout = 600
  values = [
    file("${path.module}/../../helm/redis/values.yaml")
  ]

  set {
    name = "redis.auth.password"
    value = random_password.redis.result
  }

  set {
    name = "fullnameOverride"
    value = var.name
  }
}

data "kubernetes_service" "master" {
  metadata {
    name = "${var.name}-master"
  }
  depends_on = [helm_release.app]
}
