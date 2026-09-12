variable "ingress_ports" {
    type = list(number)
}
variable "name" {
    type = string
}
variable "description" {
    type = string
}

variable "ami_id" {
    type = string
}

variable "itype" {
    type = string
}   

variable "kname" {
    type = string
}

variable "zone" {
    type = string
}

variable "size" {
    type = number
}

variable "bucket_name" {
    type = string
}