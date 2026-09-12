resource "aws_key_pair" "dev_key" {
    key_name = var.kname
    public_key = file ("~/.ssh/dev_key.pub")
}