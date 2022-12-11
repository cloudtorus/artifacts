output "master" {
  value = module.deployment.master
}

output "host" {
  value = module.deployment.host
}

output "port" {
  value = 6379
}

output "password" {
  value = module.deployment.password
  sensitive = true
}
