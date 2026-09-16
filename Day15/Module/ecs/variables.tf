variable "proj"{
    type = string
}
variable "env"{
    type = string
}
variable "tags"{
    type = map(string)
}
variable "compatibility"{
    type = string
}
variable "network_mode"{
    type = string
}
variable "cpu"{
    type = number
}
variable "memory"{
    type = number
}
variable "ecs_role"{
    type = string
}

variable "launch_type" {
  type = string
}
variable "desired_count" {
  type = number
}
variable "subnets" {
  type = list(string)
}
variable "sg" {
  type = string
}
variable "lb_tg" {
  type = string
}
variable "cont_name" {
  type = string
}
variable "cont_port" {
  type = number
}
variable "cont_def" {
  type =string
}
