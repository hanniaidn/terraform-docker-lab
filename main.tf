#Providers & AMI 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" #version constraint=version 6 or newer, but not 7; "pessimistic constraint operator"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" { #data=read only lookup
  #instead of hardcoding the AMI ID, this looks up the latest Amazon Linux 2 AMI dynamically
  most_recent = true #gets the newest one
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# IAM Role for S3 
resource "aws_iam_role" "ec2_s3_role" { #EC2 service is being allowed to use this role
  name = "ec2-s3-push-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_write_policy" {
  name = "s3-write-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject", "s3:GetObject"] #upload files and download files on all objects in the specific bucket
        Resource = "${module.s3.bucket_arn}/*"      #the /* means all objects inside the bucket
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}

# Module calls 
module "s3" {
  source      = "./modules/s3_bucket"
  bucket_name = var.s3_bucket_name
}

module "ec2_nginx" { #run NGINX 
  source        = "./modules/ec2_instance"
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  instance_name = "nginx-server"
  my_ip         = var.my_ip
  user_data     = file("${path.module}/scripts/user_data_nginx.sh")
}

module "ec2_s3_push" { #image saved to S3
  source               = "./modules/ec2_instance"
  ami_id               = data.aws_ami.amazon_linux.id
  instance_type        = "t3.micro"
  instance_name        = "s3-push-server"
  my_ip                = var.my_ip
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data            = file("${path.module}/scripts/user_data_s3_push.sh")
}
