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

variable "backend" {
  type = object({
    bucket = string
  })
}

variable "context" {
  type = object({
    id = string
    project = string
    credentials = string
    region = string
  })
}
