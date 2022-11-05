variable "installation" {
  description = "Installation id"
  type = string
}

variable "project" {
  description = "Project in Google Cloud for deployment"
  type = string
}

variable "credentials" {
  description = "Google Cloud service account"
  type = string
}

variable "region" {
  description = "Region for deployment"
  default = "us-central1"
  type = string
}

variable "backend_bucket" {
  description = "Terraform state bucket"
  type = string
}
