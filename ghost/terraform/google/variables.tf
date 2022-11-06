variable "installation" {
  description = "Installation id"
  type = string
}

variable "project" {
  description = "Project in Google Cloud for deployment"
  type = string
}

variable "region" {
  description = "Region"
  default = "us-central1"
  type = string
}

variable "credentials" {
  description = "Google Cloud service account"
  type = string
}

variable "backend_bucket" {
  description = "Terraform State Bucket (internal)"
  type = string
}
