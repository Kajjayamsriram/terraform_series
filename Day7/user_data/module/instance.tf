data "aws_security_group" "sg1" {
    name = "MY-SG"
}
resource "aws_instance" "inst1" {
    tags = var.tags
    ami = var.ami_id
    instance_type = var.itype
    availability_zone = var.zone
    vpc_security_group_ids = [data.aws_security_group.sg1.id]
    key_name = var.kname
    root_block_device {
        volume_size = var.size
    }

#1.Passing commands directly using EOF
#   user_data = <<EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum install -y httpd
# sudo systemctl enable httpd
# sudo systemctl start httpd

# cat <<HTML >/var/www/html/index.html
# <html>
# <h1>Hello from user_data</h1>
# </html>
# HTML
# EOF

#2.Passing comamnds using the script
    user_data = file("app-deploy.sh")
#3.Passing env-vars using templatefile
    # user_data = templatefile("${path.module}/userdata.sh", {
    #     env = var.environment
    #     db_endpoint = var.db_endpoint
    # })
}