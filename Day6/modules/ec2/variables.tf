variable "tags" {
    type = map(string)
}
variable "ami_id" {
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
variable "vpc_security_group_ids" {
  type = list(string)
}