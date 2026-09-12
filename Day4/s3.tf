resource "aws_s3_bucket" "s3" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.s3.id
    versioning_configuration {
        status = "Enabled"
    }
}