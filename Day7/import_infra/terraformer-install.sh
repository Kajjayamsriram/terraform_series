#Install terraformer
sudo yum install -y wget

VERSION=0.8.24
wget https://github.com/GoogleCloudPlatform/terraformer/releases/download/${VERSION}/terraformer-all-linux-amd64
chmod +x terraformer-all-linux-amd64
sudo mv terraformer-all-linux-amd64 /usr/local/bin/terraformer
terraformer version

Note: Before installing have provider.tf and run init to have required plugins for terraformer to import.

#import ec2 instances also other resource types like default vpc soon.
terraformer import aws --resources=aws_instance --regions=us-east-1
terraformer import aws --resources=vpc --regions=us-east-1

Note: To verify resource is in supported for import
terraformer import aws list

#verify generated files of imported resources
find generated -type -f

NOTE:: Terraformer project has been archived and is no longer maintained(on march/2026).
##Aws specific there's a UI option called former2 but it geneartes cloud formation template