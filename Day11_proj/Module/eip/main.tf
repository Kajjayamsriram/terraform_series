resource "aws_eip" "eip1" {
    tags = {
        Name = var.eip_name
    }
    domain = "vpc"
}