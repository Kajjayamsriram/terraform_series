variable "security_group_id"{
    type = string
}
variable "kname" {
    type = string
}
variable "ec2_inst" {
    type = map(object({
        itype = string
        ami_id = string
        vol_size = number
        subnet_name = string
    }))
}

variable "subnet_ids" {
  type = map(string)
}