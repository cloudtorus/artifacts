data "digitalocean_kubernetes_cluster" "main" {
  name = var.dependencies.cluster.name
}

provider "kubernetes" {
  host = var.dependencies.cluster.endpoint
  token = data.digitalocean_kubernetes_cluster.main.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
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
  name = "redis"
}
