resource "aws_s3_bucket" "website" {
    bucket = var.s3name
    force_destroy = true
}