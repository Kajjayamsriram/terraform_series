data "aws_key_pair" "kp" {
    key_name = "nasa"
}

resource "aws_instance" "inst" {
    for_each = {
      inst1 = data.aws_subnet.default_public1.id
      inst2 = data.aws_subnet.default_public2.id
    }
    tags ={
        Name = each.key
    }
    subnet_id = each.value
    instance_type = "t3.micro"
    ami = "ami-004f790b835b26145"
    vpc_security_group_ids = [  data.aws_security_group.demo_sg.id ]
    key_name = data.aws_key_pair.kp.key_name
    user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd amazon-efs-utils -y
    sudo systemctl start httpd
    sudo systemctl enable httpd

    sudo mount -t efs -o tls ${aws_efs_file_system.efs1.id}:/ /var/www/html
    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs1.id}.efs.us-east-1.amazonaws.com:/ /var/www/html
    
    sudo cp index.html /var/www/html
    EOF

    depends_on = [ aws_efs_file_system.efs1, aws_efs_mount_target.mount_targ ]
}