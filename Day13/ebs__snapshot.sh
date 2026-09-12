#!/bin/bash
#>create inst with data disk with /var/www/html mount and create vol from snapshot
sudo yum update -y
sudo yum install httpd -y

sudo systemctl start httpd
sudo systemctl enable httpd

#Amazon linux data disk typically has the first device name as /dev/nvme1n1
sudo mkfs.xfs /dev/nvme1n1
sudo mount /dev/nvme1n1 /var/www/html
echo "<h2>Welcome to a test website for hanging out</h2>" | sudo tee /var/www/html/index.html


########New inst
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y

sudo systemctl start httpd
sudo systemctl enable httpd
sudo mount /dev/nvme1n1 /var/www/html