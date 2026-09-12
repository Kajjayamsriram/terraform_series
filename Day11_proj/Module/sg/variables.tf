variable "sg" {
    type = map(object({
        description = string
    }))
}
variable "vpc_id" {
    type = string
}
variable "e_rule" {
    type = map(object({
        sg = string
        destination_sg = optional(string)
        port = number
        protocol = string
    }))
}
variable "in_rule" {
    type = map(object({
        sg = string
        source_sg = optional(string)
        port = number
        protocol = string
    }))
}