output "instance_details" {
    value = [ aws_instance.web.private_ip, aws_instance.web.public_ip, aws_instance.web.public_dns ]
}