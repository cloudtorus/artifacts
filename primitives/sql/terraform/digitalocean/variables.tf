variable "context" {
  type = object({
    id      = string
    project = string
    region  = string
    token   = string
  })
}

variable "engine" {
  description = "Database engine to use"
  type        = string
  default     = "pg"
}
