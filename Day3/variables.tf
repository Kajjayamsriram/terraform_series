variable "servers" {
  type = map(object({
    #name = string #since using each.key
    ami_id = string
    itype = string
    kname = string
    zone = string
    sgid = list(string)
    size = number
  }))
}

variable "buckets" {
    type = set(string)
    #type = list(string) #same syntax as set but set is more efficient than list
}