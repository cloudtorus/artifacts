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
  database_uri = var.dependencies.sql.uri
  database_ca = var.dependencies.sql.ca
  helm_release = var.helm_release
}
