variable "subnets"{
    type = map(object({
        az = string
        cidr = string
        pub = bool
    }))
}