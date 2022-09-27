data "terraform_remote_state" "google" {
  backend = "gcs"
  config = {
    bucket = var.backend_bucket
    prefix = "terraform/state/flagsmith/core"
    credentials = var.credentials
  }
}

provider "google" {
  project = data.terraform_remote_state.google.outputs.project
  credentials = var.credentials
  region = data.terraform_remote_state.google.outputs.region
}

data "google_client_config" "default" {}
data "google_container_cluster" "primary" {
  name = data.terraform_remote_state.google.outputs.cluster_name
  location = data.terraform_remote_state.google.outputs.region
}

provider "kubernetes" {
  host = "https://${data.terraform_remote_state.google.outputs.cluster_host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "flagsmith"
    labels = {
      App = "Flagsmith"
    }
  }

  spec {
    replicas = "1"

    selector {
      match_labels = {
        App = "Flagsmith"
      }
    }

    template {
      metadata {
        labels = {
          App = "Flagsmith"
        }
      }
      spec {
        container {
          image = "flagsmith/flagsmith:latest"
          name = "flagsmith"

          port {
            container_port = 8000
          }
          port {
            container_port = 5432
          }

          env {
            name = "ENV"
            value = "prod"
          }

          env {
            name = "DJANGO_ALLOWED_HOSTS"
            value = "*"
          }

          env {
            name = "DISABLE_INFLUXDB_FEATURES"
            value = "true"
          }

          env {
            name = "DATABASE_URL"
            value = data.terraform_remote_state.google.outputs.database_connection
          }

          resources {
            limits = {
              cpu = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "flagsmith"
  }
  spec {
    selector = {
      App = kubernetes_deployment.app.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port = 80
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}
