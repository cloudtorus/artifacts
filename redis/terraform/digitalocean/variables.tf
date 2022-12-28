variable "dependencies" {
  type = object({
    cluster = object({
      endpoint = string
      name = string
    })
  })
}
