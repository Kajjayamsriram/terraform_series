variable "pub_rt_name"{
    type =string
}

variable "pvt_rt_name"{
    type =string
}
variable "vpc_id"{
    type =string
}

variable "nat" {
    type = string
}
variable "igw" {
    type = string
}
variable "cidr_pvt"{
    type =string
}
variable "cidr_pub"{
    type =string
}
variable "subnets" {
  type = map(object({
    id = string
    ip = bool
  }))
}