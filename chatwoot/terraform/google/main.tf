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

data "terraform_remote_state" "redis" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/redis"
    credentials = var.credentials
  }
}

data "google_client_config" "default" {}
data "google_container_cluster" "main" {
  name = data.terraform_remote_state.cluster.outputs.name
  location = data.terraform_remote_state.cluster.outputs.region
}

provider "kubernetes" {
  host = "https://${data.terraform_remote_state.cluster.outputs.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = "https://${data.terraform_remote_state.cluster.outputs.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth[0].cluster_ca_certificate)
  }
}

module "deployment" {
  source = "../helm"
  database = {
    user = data.terraform_remote_state.sql.outputs.user
    password = data.terraform_remote_state.sql.outputs.password
    host = data.terraform_remote_state.sql.outputs.host
    port = data.terraform_remote_state.sql.outputs.port
    name = data.terraform_remote_state.sql.outputs.name
    ssl = {
      ca = data.terraform_remote_state.sql.outputs.ca
    }
  }
  redis = {
    host = data.terraform_remote_state.redis.outputs.host
    port = data.terraform_remote_state.redis.outputs.port
    password = data.terraform_remote_state.redis.outputs.password
  }
}
