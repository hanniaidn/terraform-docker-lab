#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
docker pull hanidn/nginx-handson:v1
docker run -d -p 80:80 hanidn/nginx-handson:v1