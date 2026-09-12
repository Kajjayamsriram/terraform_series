variable "name" {
    description = "Name of the Instance"
    type = string
}
variable "ami_id" {
    description = "AMI ID"
    type = string
}
variable "itype" {
    description = "Instance type"
    type = string
}
variable "kname" {
    description = "Name of the Key"
    type = string
}
variable "zone" {
    description = "Availability Zone"
    type = string
}
variable "sgid" {
    description = "Security group of Instance"
    type = list(string)
}
variable "size" {
    description = "Size of the instance"
    type = number
}