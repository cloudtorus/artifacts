variable "dependencies" {
  type = object({
    cluster = object({
      endpoint = string
      name = string
    })
    database = object({
      user = string
      password = string
      host = string
      port = number
      name = string
      ca = string
    })
    redis = object({
      host = string
      port = number
      password = string
    })
  })
}
