variable "lb_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "internal" {
  type = bool
}

variable "sg" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}