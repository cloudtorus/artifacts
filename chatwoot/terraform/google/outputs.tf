output "host" {
  value = module.deployment.host
}

output "all" {
  value = {
    host = module.deployment.host
  }
}
