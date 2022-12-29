variable "backend" {
  type = object({
    bucket     = string,
    access_key = string,
    secret_key = string,
  })
}

variable "context" {
  type = object({
    id      = string
    project = string
    region  = string
    token   = string
  })
}
