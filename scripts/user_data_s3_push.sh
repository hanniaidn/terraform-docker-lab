#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
docker pull hanidn/nginx-handson:v1
docker save hanidn/nginx-handson:v1 -o /tmp/nginx-image.tar
yum install -y aws-cli
aws s3 cp /tmp/nginx-image.tar s3://s3-docker-terra-lab/nginx-image.tar