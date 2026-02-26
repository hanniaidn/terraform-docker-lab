# Definition of variables 

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "my_ip" {
  description = "Laptop's IP"
  type        = string
}

variable "docker_image" {
  description = "Docker Hub image name"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}
