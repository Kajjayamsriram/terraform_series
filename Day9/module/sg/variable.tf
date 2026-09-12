variable "egress_values" {
    type = list(object({
        port = number
        protocol = string
        cidr = list(string)
    }))
}

variable "ingress_values" {
    type = list(object({
        port = number
        protocol = string
        cidr = list(string)
    }))
}
variable "sg_name" {
    type = string
}
variable "sg_des" {
    type = string
}
variable "vpc_id" {
    type = string
}