# SG (virtual firewall for the instance )
resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "SG for ${var.instance_name}"

  ingress { #incoming traffic
    description = "HTTP only from my laptop"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" # robust protocol 
    cidr_blocks = ["${var.my_ip}/32"] #list of IP addresses allowed, the /32 suffix limits access to just that IP address 
  }

  egress { #outgoing traffic 
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allow all 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance 
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = var.user_data
  iam_instance_profile   = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  #for the 2nd instance. if the variable is not empty, use it, otherwise use null (tells AWS to attach no instance profile:D)

  tags = {
    Name = var.instance_name
  }
}
