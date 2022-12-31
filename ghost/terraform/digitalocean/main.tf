resource "random_password" "mysql_password" {
  length = 32
  special = false
}
