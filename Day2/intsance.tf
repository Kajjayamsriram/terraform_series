resource "aws_instance" "inst1" {
    tags = {
        Name = var.name
    }
  ami = var.ami_id
  instance_type = var.itype
  key_name = var.kname
  availability_zone = var.zone
  vpc_security_group_ids = var.sgid
  root_block_device {
    volume_size = var.size
  }
}