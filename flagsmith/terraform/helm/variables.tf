variable "database_uri" {
  description = "Database URI"
}

variable "database_ca" {
  description = "Database CA Certificate"
  default = ""
}

variable "helm_release" {
  type = object({
    chart = string
    values = string
  })
}
