output "mysql-innodbcluster" {
  value = {
    credentials = {
      root = {
        password = random_password.mysql_password.result
      }
    }
  }
}
