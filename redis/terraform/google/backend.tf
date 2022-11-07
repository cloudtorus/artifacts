terraform {
  backend "gcs" {
    prefix = "terraform/redis"
  }
}
