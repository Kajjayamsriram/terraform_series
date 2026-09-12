variable "asg_name"{
    type = string
}
variable "lt"{
    type = string
}
variable "subnets"{
    type = list(string)
}
variable "min"{
    type = number
}
variable "max"{
    type = number
}
variable "desired"{
    type = number
}
variable "policy_name"{
    type = string
}
variable "policy_type"{
    type = string
}

variable "target_value"{
    type = number
}
variable "sns"{
    type = string
}
variable "tg" {
  type = list(string)
}