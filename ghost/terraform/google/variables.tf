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
      endpoint = string
      name     = string
    })
    database = object({
      user     = string
      password = string
      host     = string
      port     = number
      name     = string
      ca       = string
    })
  })
}
