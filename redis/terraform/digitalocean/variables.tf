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
  })
}
