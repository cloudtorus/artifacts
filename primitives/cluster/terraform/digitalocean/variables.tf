variable "k8s_node_pool_size" {
  description = "Kubernetes Node Pool Size"
  type = string
  default = "s-1vcpu-2gb"
}

variable "context" {
  type = object({
    id = string
    project = string
    region = string
    token = string
  })
}
