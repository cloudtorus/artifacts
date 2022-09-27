variable "project" {
  description = "Project in DigitalOcean for deployment"
  type = string
}

variable "token" {
  description = "Personal Access Token to use for authentication"
  type = string
}

variable "spaces_access_id" {
  description = "DigitalOcean Spaces Access Key"
}

variable "spaces_secret_key" {
  description = "DigitalOcean Spaces Secret Key"
}

variable "storage_bucket" {
  description = "Bucket to store Terraform state in"
  type = string
}
