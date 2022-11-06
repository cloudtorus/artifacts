data "terraform_remote_state" "cluster" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/primitives/cluster"
    credentials = var.credentials
  }
}

data "terraform_remote_state" "sql" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/primitives/sql"
    credentials = var.credentials
  }
}

data "google_client_config" "default" {}
data "google_container_cluster" "main" {
  name = data.terraform_remote_state.cluster.outputs.name
  location = data.terraform_remote_state.cluster.outputs.region
}

provider "kubernetes" {
  host = "https://${data.terraform_remote_state.cluster.outputs.host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = "https://${data.terraform_remote_state.cluster.outputs.host}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
  }
}

module "deployment" {
  source = "../helm"
  database_uri = data.terraform_remote_state.sql.outputs.uri
  database_ca = data.terraform_remote_state.sql.outputs.ca
}
