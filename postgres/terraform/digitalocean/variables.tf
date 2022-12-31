variable "context" {
  type = object({
    id      = string
    project = string
    region  = string
    token   = string
    access_key = string
    secret_key = string
  })
}

variable "dependencies" {
  type = any
}
