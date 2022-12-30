variable "recipe" {
  type = any
  default = {}
}

output "ip_address" {
  value = data.kubernetes_service.chatwoot.status.0.load_balancer.0.ingress.0.ip
}

output "all" {
  value = {
    ip_address = data.kubernetes_service.chatwoot.status.0.load_balancer.0.ingress.0.ip
  }
}
