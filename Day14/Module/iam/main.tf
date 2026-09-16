resource "aws_iam_role" "cluster_role" {
    name = "eks_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service" : [
                        "eks.amazonaws.com"
                    ]
                },  
                "Action": "sts:AssumeRole"
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "eks_policy" {
    role = aws_iam_role.cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/${var.eks_policy}"
}

#AmazonEKSClusterPolicy

resource "aws_iam_role" "node_role" {
    name = "node_role"
    assume_role_policy = jsonencode({
        "Version" : "2012-10-17"
        "Statement" : [
            {
                "Effect" : "Allow"
                "Principal" : {
                    "Service" : [
                        "ec2.amazonaws.com"
                    ]
                },
                "Action" : "sts:AssumeRole"
            }
        ]
    })
}
resource "aws_iam_role_policy_attachment" "ec2_policy" {
    for_each = var.ec2_policy
    role = aws_iam_role.node_role.name
    policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

#AmazonEKSWorkerNodePolicy,AmazonEC2ContainerRegistryPullOnly,AmazonEKS_CNI_Policy

resource "aws_iam_role" "eks_admin" {
    name = "ec2_access_cluster"
    assume_role_policy = jsonencode({
        "Version" : "2012-10-17"
        "Statement" : [
        {
            "Effect" : "Allow"
            "Principal" : {
                "Service" : [
                    "ec2.amazonaws.com"
                ]
            },
            "Action" : "sts:AssumeRole"
        }
        ]
    })
}
resource "aws_iam_role_policy" "eks_describe" {
    role = aws_iam_role.eks_admin.name
    policy = jsonencode({
        "Version" = "2012-10-17",
        "Statement" = [
            {
                "Effect" = "Allow",
                "Action" = [
                    "eks:DescribeCluster",
                    "ecr:GetAuthorizationToken",
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:InitiateLayerUpload",
                    "ecr:UploadLayerPart",
                    "ecr:CompleteLayerUpload",
                    "ecr:PutImage"
                ]
                "Resource" = "*"
            }
        ]
    })
}


resource "aws_iam_instance_profile" "inst_profile" {
  role = aws_iam_role.eks_admin.name
  name = "inst_profile"
}