#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

cat <<HTML >/var/www/html/index.html
<html>
<h1>Hello from user_data</h1>
</html>