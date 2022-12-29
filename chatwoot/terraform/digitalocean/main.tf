resource "random_password" "secret_key" {
  length = 32
  special = false
}
