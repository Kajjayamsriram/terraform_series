variable "pub_rt_name" {
    type = string
}
variable "pvt_rt_name" {
    type = string
}
variable "vpc_id" {
  type = string
}
variable "nat_gw"{
    type = string
}
variable "igw"{
    type = string
}
variable "subnet_ids" {
    type = map(string)
}