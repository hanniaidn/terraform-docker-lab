# Outputs on terminal 

output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" { #ARN=Amazon Resource Name (unique identifier)
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.this.arn
}
