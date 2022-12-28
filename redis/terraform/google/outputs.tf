output "all" {
  sensitive = true
  value = {
    master = module.deployment.master
    host = module.deployment.host
    port = 6379
    password = module.deployment.password
  }
}
