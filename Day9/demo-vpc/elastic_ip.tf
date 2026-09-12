resource "aws_eip" "eip1" {
    domain = "vpc"
    tags = {
        Name = "nat-eip"
    }
}