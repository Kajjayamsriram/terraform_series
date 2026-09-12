variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "ingress_values" {
  type = list(object({
    port     = number
    protocol = string
    cidrs    = list(string)
  }))
}

variable "egress_values" {
  type = list(object({
    port     = number
    protocol = string
    cidrs    = list(string)
  }))
}