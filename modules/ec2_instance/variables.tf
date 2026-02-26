# Definition of variables 

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "user_data" {
  description = "Shell script to run (beginning)"
  type        = string
  default     = ""
}

variable "my_ip" {
  description = "Laptop's IP"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile to attach"
  type        = string
  default     = ""
}
