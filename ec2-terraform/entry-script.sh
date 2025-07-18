#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user # we want to run docker commands without sudo
docker run -p 8080:80 nginx
