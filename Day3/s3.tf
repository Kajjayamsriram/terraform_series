resource "aws_s3_bucket" "bucket" {
    for_each = var.buckets
    bucket = each.key
}

resource "aws_s3_bucket_versioning" "bucket_vers" {
    for_each = var.buckets
    bucket = aws_s3_bucket.bucket[each.key].id
    versioning_configuration {
        status = "Enabled"
    }
}