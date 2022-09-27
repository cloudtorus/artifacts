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
