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
            value = var.database_uri
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
