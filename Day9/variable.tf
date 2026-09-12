variable "tenancy" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "dns" {
    type = bool
}
variable "subnet" {
    type = map(object({
        az = string
        subnet_cidr = string
        pub_ip = bool
    }))
}
variable "igw_name"{
    type = string
}
variable "nat_name" {
    type = string
}
variable "av_mode" {
    type = string
}
variable "con_type" {
    type = string
}
variable "pub_rt_name"{
    type = string
}
variable "pvt_rt_name"{
    type = string
}
variable "kname"{
    type = string
} 
variable "sg_name"{
    type = string
}
variable "sg_des"{
    type = string
}
variable "ingress_values"{
    type = list(object({
        port = number
        protocol = string
        cidr = list(string)
    }))
}
variable "egress_values"{
    type = list(object({
        port = number
        protocol = string
        cidr = list(string)
    }))
}

variable "eip_name" {
    type = string
}

variable "ec2_i" {
    type = map(object({
        itype = string
        ami_id = string
        vol_size = number
        subnet_name = string
    }))
}