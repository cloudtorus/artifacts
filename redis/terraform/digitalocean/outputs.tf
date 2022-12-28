output "all" {
  sensitive = true
  value = {
    master = module.deployment.master
    host = module.deployment.host
    port = module.deployment.port
    password = module.deployment.password
  }
}
