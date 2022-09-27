data "terraform_remote_state" "pgsql_db" {
  backend = "s3"
  config {
    bucket = var.backend_bucket
    prefix = "state/pgsql"
  }
}

data "terraform_remote_state" "k8s" {
  backend = "s3"
  config {
    bucket = var.backend_bucket
    prefix = "state/k8s"
  }
}

data "digitalocean_kubernetes_cluster" "main" {
  name = data.terraform_remote_state.k8s.k8s_cluster_name
  location = data.terraform_remote_state.k8s.k8s_cluster_region
}

provider "kubernetes" {
  host = "https://${data.terraform_remote_state.k8s.k8s_cluster_endpoint}"
  token = data.digitalocean_kubernetes_cluster.main.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
}

module "deployment" {
  source = "../common/deployment"
  database_uri = data.terraform_remote_state.pgsql_db.pgsql_db_uri
}
