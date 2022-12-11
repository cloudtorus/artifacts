output "master" {
  value = {
    host = data.kubernetes_service.master.spec.0.cluster_ip
  }
}

output "host" {
  value = data.kubernetes_service.master.spec.0.cluster_ip
}

output "port" {
  value = 6379
}

output "password" {
  value = random_password.redis.result
  sensitive = true
}
