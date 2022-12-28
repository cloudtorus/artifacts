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

variable "context" {
  type = object({
    id = string
    project = string
    region = string
    token = string
  })
}
