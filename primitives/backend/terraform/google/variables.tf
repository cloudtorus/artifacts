variable "project" {
  description = "Project in Google Cloud for deployment"
  type = string
}

variable "credentials" {
  description = "Google Cloud service account"
  type = string
}

variable "storage_bucket" {
  description = "Bucket to store Terraform in state"
  type = string
}

variable "google_apis" {
  description = "Services to enable"
  type = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}
