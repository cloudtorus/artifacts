variable "installation" {
  description = "Installation id"
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
