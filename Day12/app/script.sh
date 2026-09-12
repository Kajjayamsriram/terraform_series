#!/bin/bash
sudo yum update -y
sudo yum install docker -y

sudo systemctl enable --now docker
cd /home/ec2-user/app
sudo chmod 666 /var/run/docker.sock

sudo docker build -t sriramk16/private_img .

sudo echo "$DOCKER_PASSWORD" | docker login \
  --username "$DOCKER_USER" \
  --password-stdin
sudo docker push sriramk16/private_img
