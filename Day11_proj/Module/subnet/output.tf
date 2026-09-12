output "subnets" {
    value ={
        for name, subnet in aws_subnet.subnets :
        name => {
            id  = subnet.id
            ip = var.subnets[name].ip
        }
    }
}