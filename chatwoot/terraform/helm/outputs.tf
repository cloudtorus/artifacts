output "host" {
  value = data.kubernetes_service.chatwoot.status.0.load_balancer.0.ingress.0.ip
}
