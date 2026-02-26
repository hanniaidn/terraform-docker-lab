# S3 bucket
resource "aws_s3_bucket" "this" { #creates bucket 
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_ownership_controls" "this" { #to explicitly set object ownership
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerPreferred" #whoever created the bucket owns all objects
  }
}

resource "aws_s3_bucket_acl" "this" { #ACL is private
  depends_on = [aws_s3_bucket_ownership_controls.this] #create the "ownership_controls" resource before the ACL
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
}
