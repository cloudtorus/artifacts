data "terraform_remote_state" "pgsql_db" {
  backend = "s3"
  config = {
    endpoint = "https://${var.region}.digitaloceanspaces.com"
    region = "us-east-1"
    bucket = var.backend_bucket
    key = "postgresql.terraform.tfstate"
    access_key = var.spaces_access_id
    secret_key = var.spaces_secret_key
    skip_credentials_validation = true
    skip_region_validation = true
  }
}

data "terraform_remote_state" "k8s" {
  backend = "s3"
  config = {
    endpoint = "https://${var.region}.digitaloceanspaces.com"
    region = "us-east-1"
    bucket = var.backend_bucket
    key = "k8s.terraform.tfstate"
    access_key = var.spaces_access_id
    secret_key = var.spaces_secret_key
    skip_credentials_validation = true
    skip_region_validation = true
  }
}

data "digitalocean_kubernetes_cluster" "main" {
  name = data.terraform_remote_state.k8s.outputs.k8s_cluster_name
}

provider "kubernetes" {
  host = data.terraform_remote_state.k8s.outputs.k8s_cluster_endpoint
  token = data.digitalocean_kubernetes_cluster.main.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
}

module "deployment" {
  source = "../common/deployment"
  database_uri = data.terraform_remote_state.pgsql_db.outputs.pgsql_db_uri
}
