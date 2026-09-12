subnets = {
    private1 = {
      cidr = "10.0.0.0/26"
      az   = "us-east-1a"
      pub  = false
    }

    private2 = {
      cidr = "10.0.0.64/26"
      az   = "us-east-1b"
      pub  = false
    }

    public1 = {
      cidr = "10.0.0.128/26"
      az   = "us-east-1a"
      pub  = true
    }

    public2 = {
      cidr = "10.0.0.192/26"
      az   = "us-east-1b"
      pub  = true
    }
}