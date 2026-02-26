# Outputs on terminal 

output "nginx_instance_public_ip" {
  description = "NGINX EC2 instance public IP"
  value       = module.ec2_nginx.public_ip
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3.bucket_name
}
