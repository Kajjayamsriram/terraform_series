variable "project" {
  type = string
}
variable "env" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "internal" {
  type = bool
}
variable "load_balancer_type" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "sg" {
  type = list(string)
}