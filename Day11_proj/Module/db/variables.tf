variable "subnets" {
    type = list(string)
}
variable "iden_name" {
    type = string
}
variable "eng" {
    type = string
}
variable "eng_ver" {
    type = string
}
variable "iclass" {
    type = string
}
variable "storage" {
    type = number
}
variable "max_storage" {
    type = number
}
variable "db_name" {
    type = string
}
variable "usr_name" {
    type = string
}
variable "pass" {
    type = string
    sensitive = true  
}
variable "sg" {
  type = list(string)
}
variable "db_port"{
    type = number
}