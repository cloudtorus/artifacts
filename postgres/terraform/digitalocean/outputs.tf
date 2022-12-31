output "s3" {
  value = {
    key = var.context.access_key
    keySecret = var.context.secret_key
  }
}
