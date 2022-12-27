resource "random_password" "secret_key" {
  length = 32
  special = false
}

resource "helm_release" "chatwoot" {
  chart = "${path.module}/../../helm/chatwoot"
  name  = "chatwoot"
  timeout = 600
  version = "2.10.0"

  set {
    name = "database.user"
    value = var.database.user
  }
  set {
    name = "database.password"
    value = var.database.password
  }
  set {
    name = "database.host"
    value = var.database.host
  }
  set {
    name = "database.port"
    value = var.database.port
  }
  set {
    name = "database.name"
    value = var.database.name
  }
  set {
    name = "database.ssl.ca"
    value = var.database.ssl.ca
  }

  set {
    name = "redis.host"
    value = var.redis.host
  }
  set {
    name = "redis.port"
    value = var.redis.port
  }
  set {
    name = "redis.password"
    value = var.redis.password
  }

  set {
    name = "env.SECRET_KEY_BASE"
    value = random_password.secret_key.result
  }
}

data "kubernetes_service" "chatwoot" {
  metadata {
    name = "chatwoot"
  }
  depends_on = [helm_release.chatwoot]
}
