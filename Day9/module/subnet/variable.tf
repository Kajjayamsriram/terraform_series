# variable "vpc_id" {
#     type = string
# }

variable "subnet" {
    type = map(object({
    subnet_cidr = string
    az = string
    pub_ip = bool
    }))
}
variable "vpc_id" {
    type = string
}
