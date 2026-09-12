#!/bin/bash
yum update -y
yum install docker -y
systemctl start docker && systemctl enable docker
chmod 666 /var/run/docker.sock
docker build -t sriramk16/private_img .

docker push sriramk16/private_img