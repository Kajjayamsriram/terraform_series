servers = {
    tdevserv = {
        ami_id = "ami-004f790b835b26145"
        itype = "t3.micro"
        kname = "Luffy-kp"
        zone = "us-east-1a"
        sgid = ["sg-0cc6db8ed39b7f31d"]
        size = 10
    }
    tpreprodserv = {
        ami_id = "ami-004f790b835b26145"
        itype = "c7i-flex.large"
        kname = "Luffy-kp"
        zone = "us-east-1b"
        sgid = ["sg-0cc6db8ed39b7f31d"]
        size = 10
    }
}
buckets = ["tdevbucket.19023", "tpreprodbucket.19078"]