data "aws_security_group" "sg" {
    name = "demo_sg"
}
data "aws_key_pair" "kp" {
    key_name  ="nasa"
}

resource "aws_instance" "inst1" {
    tags = {
        Name = "testInst"
    }
    ami = "ami-0354c98ae10b02961"
    instance_type = "t3.micro"
    availability_zone = "us-east-1a"
    vpc_security_group_ids = [ data.aws_security_group.sg.id ]
    key_name = data.aws_key_pair.kp.key_name
    root_block_device {
      volume_size = 10
    }
    user_data = file(script.sh)
}

resource "null_resource" "build_image" {

  connection {
    type        = "ssh"
    host        = aws_instance.inst1.public_ip
    user        = "ec2-user"
    private_key = file("nasa.pem")
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/home/ec2-user/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/script.sh",
      "DOCKER_USER='${data.vault_kv_secret_v2.docker.data["username"]}' DOCKER_PASSWORD='${data.vault_kv_secret_v2.docker.data["password"]}' /home/ec2-user/script.sh"
    ]
  }
}