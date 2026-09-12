#creates a bucket in aws
aws s3 mb s3://testbucket123456gy

#copies to s3 with bucket-owner acl
aws s3 cp testfile s3://testbucket123456gy --acl bucket-owner-full-control

#listing objects
aws s3api list-objects --bucket testbucket123456gy

#deleting an object
aws s3api delete-object aws s3api delete-object --bucket testbucket123456gy --key test.img

#deleting a bucket
aws s3 rb s3://testbucket123456gy

Note: Deletion fails if the s3 bucket is not empty