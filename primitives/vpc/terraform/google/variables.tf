variable "context" {
  type = object({
    id = string
    project = string
    credentials = string
    region = string
  })
}
