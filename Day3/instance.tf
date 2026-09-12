resource "aws_instance" "server" {
  for_each = var.servers
  tags = {
    Name = each.key
  }
  ami = each.value.ami_id
  instance_type = each.value.itype
  key_name = each.value.kname
  availability_zone = each.value.zone
  vpc_security_group_ids = each.value.sgid
  root_block_device {
    volume_size = each.value.size
  }
}