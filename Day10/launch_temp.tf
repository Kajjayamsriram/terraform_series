resource "aws_launch_template" "lt1" {
    name = "demo-lt1"
    tags = {
        Name = "demo_app"
    }
    description = "This is a demo application for tiny_app"
    image_id = "ami-081b0a6eac00b4f53"
    instance_type = "t3.micro"
    key_name = aws_key_pair.key1.key_name
    vpc_security_group_ids = [aws_security_group.sg1.id]
    block_device_mappings {
        device_name = "/dev/xvda"

        ebs {
        volume_size = 11
        }
    }
    tag_specifications {
      resource_type = "instance"
      tags ={
        Name = "demo_app"
      }
    }
    user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd && systemctl enable httpd
    echo "<h3>Hello from the host-> $(hostname)</h3>" > /var/www/html/index.html
    EOF
    )
    depends_on = [ aws_key_pair.key1, aws_security_group.sg1 ]
}
#note: always match the root volume device_name or else it creates new disk