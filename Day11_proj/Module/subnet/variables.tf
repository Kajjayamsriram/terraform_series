variable "vpc_id" {
    type = string
}
variable "subnets"{
    type = map(object({
        az = string
        cidr = string
        ip = bool
    }))
}
