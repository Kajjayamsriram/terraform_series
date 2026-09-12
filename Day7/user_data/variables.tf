variable "tags" {
    type = map(string)
}
variable "ami_id" {
    type =string
}
variable "itype" {
    type = string
}
variable "zone" {
    type = string
}
variable "kname" {
    type = string
}
variable "size" {
    type = number
}
# variable "env" {
#     type = string
# }
# variable "db_conn" {
#     type = string
# }