### S3 bucket to be used as backend for the solution
resource "aws_s3_bucket" "bucket" {
  bucket = "challenge-iagomisko-terraform-states"

  tags = { 
    Name = "challenge-iagomisko-terraform-states"
  }
}

### ACL to control bucket access
resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

### Bucket ownership
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

### Restrict access to the bucket
resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

