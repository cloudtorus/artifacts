variable "context" {
  type = object({
    id = string
    project = string
    credentials = string
    region = string
  })
}

variable "dependencies" {
  type = object({
    cluster = object({
      name = string
      endpoint = string
    })
    sql = object({
      uri = string
      ca = string
    })
  })
}
