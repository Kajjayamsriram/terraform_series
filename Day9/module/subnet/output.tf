output "subnet_ids"{
    value = {
        for name, subnet in aws_subnet.subnet :
        name => subnet.id
    }
}