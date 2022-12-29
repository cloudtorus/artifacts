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
      vpc_id = string
    })
  })
}

variable "engine" {
  description = "Engine - mysql or pg"
  default     = "pg"
  type        = string
}

