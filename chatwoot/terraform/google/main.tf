data "google_client_config" "default" {}
data "google_container_cluster" "main" {
  name = var.dependencies.cluster.name
  location = var.context.region
}

provider "kubernetes" {
  host = "https://${var.dependencies.cluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = "https://${var.dependencies.cluster.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
  }
}

module "deployment" {
  source = "../helm"
  database = {
    user = var.dependencies.database.user
    password = var.dependencies.database.password
    host = var.dependencies.database.host
    port = var.dependencies.database.port
    name = var.dependencies.database.name
    ssl = {
      ca = var.dependencies.database.ca
    }
  }
  redis = {
    host = var.dependencies.redis.host
    port = var.dependencies.redis.port
    password = var.dependencies.redis.password
  }
}
