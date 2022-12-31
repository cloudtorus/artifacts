variable "context" {
  type = object({
    id      = string
  })
}

variable "dependencies" {
  type = any
}
