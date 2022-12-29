resource "google_project_service" "storage" {
  project = var.context.project
  service = "storage.googleapis.com"
}

resource "google_storage_bucket" "terraform" {
  name = var.backend.bucket
  project = var.context.project
  force_destroy = false
  location = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }
}

resource "google_project_service" "google_apis" {
  count = length(var.google_apis)
  project = var.context.project
  service = var.google_apis[count.index]
  disable_on_destroy = false

  lifecycle {
    prevent_destroy = true
  }
}
