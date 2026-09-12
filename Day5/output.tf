output "bucket_names" {
    value = [aws_s3_bucket.s3.id, aws_s3_bucket.wests3.id]
}
output "instance_ip" {
    value = aws_instance.web[*].public_ip
}