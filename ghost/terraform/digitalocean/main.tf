data  "digitalocean_kubernetes_cluster" "main" {
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
}
