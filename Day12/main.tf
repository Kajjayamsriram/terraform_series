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


data "docker_generic_secret" "docker" {
    path = "secret/docker"
}

resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    environment = {
      DOCKER_USER = data.docker_generic_secret.docker.data["username"]
      DOCKER_PASSWORD = data.docker_generic_secret.docker.data["password"]
    }
    command  = "echo \"$DOCKER_PASSWORD\" | docker login --username \"$DOCKER_USER\" --password-stdin"
  }
}
resource "null_resource" "build_image" {
  depends_on = [ null_resource.docker_login ]
  provisioner "local-exec" {
    command = "./script.sh"
  }
}