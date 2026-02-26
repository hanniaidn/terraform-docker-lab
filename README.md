# Terraform & Docker Hands On Lab
 
This lab builds an AWS infrastructure using Terraform and Docker, deploying an NGINX container on EC2 and storing a Docker image in S3

## What This Does
- Provisions two EC2 instances using a reusable Terraform module
- First EC2 instance runs a Dockerized NGINX container serving a custom webpage, accessible only from a specific IP (user's laptop IP)
- Second EC2 instance pulls the Docker image, saves it as a .tar file, and uploads it to an S3 bucket
- S3 bucket is provisioned using a separate reusable Terraform module
- EC2 instance permissions to write to S3 are managed via an IAM Role

## Notes

- `terraform.tfvars` is excluded, but the variables need it are in `terraform.tfvars.temp` so just copy the file
- Both EC2 instances use `t3.micro`
- AWS User already configured, in AWS CLI use the `aws configure` command to establish this setup 
