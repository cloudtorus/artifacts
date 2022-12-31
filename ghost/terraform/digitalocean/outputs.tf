output "ghost" {
  value = {
    test = 1
    mysql-innodbcluster = {
      credentials = {
        root = {
          password = random_password.mysql_password.result
        }
      }
    }
  }
}
