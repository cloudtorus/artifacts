variable "recipe" {
  type = any
  default = {}
}

output "all" {
  sensitive = true
  value = {
    master = {
      host = data.kubernetes_service.master.spec.0.cluster_ip
    }
    host = data.kubernetes_service.master.spec.0.cluster_ip
    port = 6379
    password = data.kubernetes_secret.redis-password.data.password
  }
}
