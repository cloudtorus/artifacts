variable "context" {
  type = object({
    id = string
    project = string
    region = string
    token = string
  })
}

variable "dependencies" {
  type = object({
    cluster = object({
      endpoint = string
      name = string
    })
    database = object({
      uri = string
      ca = string
    })
  })
}

variable "helm_release" {
  type = object({
    chart = string
    values = string
  })
}
