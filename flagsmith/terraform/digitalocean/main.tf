data "digitalocean_kubernetes_cluster" "main" {
  name = var.dependencies.cluster.name
}

provider "helm" {
  kubernetes {
    host                   = var.dependencies.cluster.endpoint
    token                  = data.digitalocean_kubernetes_cluster.main.kube_config[0].token
    cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
  }
}

module "deployment" {
  source = "../helm"
  database_uri = var.dependencies.database.uri
  database_ca =  var.dependencies.database.ca
  helm_release = var.helm_release
}
