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
