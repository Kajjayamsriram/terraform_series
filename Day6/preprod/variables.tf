variable "tags" {
  type = map(string)
}

variable "ami" {
  type = string
}

variable "itype" {
    type = string
}
variable "zone"{
    type = string
}
variable "kname"{
    type = string
}
variable "size" {
  type = number
}

variable "name" {
    type = string
}
variable "description" {
  type = string
}
variable "ingress_values" {
  type = list(object({
    port = number
    protocol = string
    cidrs = list(string)
  }))
}
variable "egress_values" {
  type = list(object({
    port = number
    protocol = string
    cidrs = list(string)
  }))
}
variable "bucket" {
    type = string
}