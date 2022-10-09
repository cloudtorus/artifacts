variable "installation" {
  description = "Installation id"
  type = string
}

variable "project" {
  description = "Project in DigitalOcean for deployment"
  type = string
}

variable "region" {
  description = "Region"
  type = string
}

variable "token" {
  description = "Personal Access Token to use for authentication"
  type = string
}

variable "spaces_access_id" {
  description = "DigitalOcean Spaces Access Key"
  type = string
}

variable "spaces_secret_key" {
  description = "DigitalOcean Spaces Secret Key"
  type = string
}

variable "backend_bucket" {
  description = "Backend bucket for Terraform state"
  type = string
}
