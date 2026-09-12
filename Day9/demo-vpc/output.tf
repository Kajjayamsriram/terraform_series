output "instance_pub_ips"{
    value = [for instance in aws_instance.inst : instance.public_ip]
}