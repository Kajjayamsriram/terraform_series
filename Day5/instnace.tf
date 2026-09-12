data "aws_security_group" "sg1" {
  name = "MY-SG"
}
resource "aws_instance" "web" {
  tags = {
    Name = var.iname
    Env = "Dev"
  }
  count=2
  ami           = var.ami
  instance_type = var.itype
  availability_zone = var.zone
  key_name = var.kname
  vpc_security_group_ids = [data.aws_security_group.sg1.id]
  #disable_api_termination = true
  lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    ignore_changes = [tags]
  }
}