resource "random_password" "redis" {
  length = 32
}

resource "helm_release" "app" {
  chart = "${path.module}/../../helm/redis"
  name = "redis"

  values = [
    file("${path.module}/../../helm/redis/values.yaml")
  ]

  set {
    name = "redis.auth.password"
    value = random_password.redis.result
  }
}
