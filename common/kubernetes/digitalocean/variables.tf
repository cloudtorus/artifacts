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
  default = "nyc3"
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

variable "k8s_node_pool_size" {
  description = "Kubernetes Node Pool Size"
  type = number
  default = "s-1vcpu-2gb"
}
