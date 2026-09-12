resource "aws_s3_bucket" "s3" {
    bucket = var.bucket_name1
}

resource "aws_s3_bucket" "wests3" {
    provider = aws.uswest
    bucket = var.bucket_name2
}