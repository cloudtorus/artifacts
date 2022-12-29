variable "context" {
  type = object({
    id          = string
    project     = string
    credentials = string
    region      = string
  })
}

variable "dependencies" {
  type = object({
    vpc = object({
      vpc_id      = string
      subnet_name = string
    })
  })
}
