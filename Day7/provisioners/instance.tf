data "aws_security_group" "sg1" {
    name = "MY-SG"
}
resource "aws_instance" "inst1" {
    tags = var.tags
    ami = var.ami_id
    instance_type = var.itype
    availability_zone = var.zone
    vpc_security_group_ids = [data.aws_security_group.sg1.id]
    key_name = var.kname
    root_block_device {
        volume_size = var.size
    }
    provisioner "local-exec" {
        command = "echo ${self.tags.Name}\t${self.public_ip} >> inventory.txt"
    }
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("Luffy.pem")
        host = self.public_ip
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y && sudo yum install httpd -y",
            "sudo systemctl start httpd"
        ]
    }
    provisioner "file" {
        source = "index.html"
        destination = "/tmp/index.html"
    }
    provisioner "remote-exec" {
        script = "deploy-app.sh"
    }
}