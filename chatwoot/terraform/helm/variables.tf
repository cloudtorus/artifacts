variable "database" {
  type = object({
    user = string
    password = string
    host = string
    port = number
    name = string
    ssl = object({
      ca = string
    })
  })
  sensitive = true
  description = "Database configuration"
}

variable "redis" {
  type = object({
    host = string
    port = number
    password = string
  })
}
