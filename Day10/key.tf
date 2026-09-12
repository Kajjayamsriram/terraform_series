resource "aws_key_pair" "key1" {
    key_name = "demo_key"
    public_key = file("~/.ssh/dev_key.pub")
}