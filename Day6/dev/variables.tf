variable "tags" {
    type = map(string)
}
variable "amitest" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "key_name" {
    type = string
}
variable "availability_zone" {
    type = string
}
variable "volume_size" {
    type = number
}

variable "bucket" {
    type = string
}

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