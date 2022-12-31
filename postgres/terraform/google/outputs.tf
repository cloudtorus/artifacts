variable "recipe" {
  type = any
  default = {}
}

output "gcs" {
  value = {
    key = var.context.credentials
  }
}
