output "env" {
  value = {
    SECRET_KEY = random_password.secret_key.result
  }
}
