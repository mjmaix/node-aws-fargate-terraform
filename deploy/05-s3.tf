resource "aws_s3_bucket" "node_app" {
  bucket        = var.app_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "node_app_bucket_acl" {
  bucket = aws_s3_bucket.node_app.id
  acl    = "private"
}
