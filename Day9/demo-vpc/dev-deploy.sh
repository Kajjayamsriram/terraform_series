#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
cat <<EOF >/var/www/html/index.html
<html>
<h1>Hello from $(hostname -i)</h1>
</html>
EOF