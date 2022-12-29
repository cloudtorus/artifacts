output "ip_address" {
  value = data.kubernetes_service.ghost.status.0.load_balancer.0.ingress.0.ip
}

output "all" {
  value = {
    ip_address = data.kubernetes_service.ghost.status.0.load_balancer.0.ingress.0.ip
  }
}
