variable "context" {
  type = object({
    id      = string
    project = string
    region  = string
    token   = string
  })
}
