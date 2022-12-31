output "ghost" {
  value = {
    mysql-innodbcluster = {
      credentials = {
        root = {
          password = random_password.mysql_password.result
        }
      }
    }
  }
}
