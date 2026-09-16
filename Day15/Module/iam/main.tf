resource "aws_iam_role" "ecs_role" {
    name = var.ecs_role_name
    assume_role_policy = var.ecs_role_json
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
    policy_arn = "arn:aws:iam::aws:policy/service-role/${var.ecs_policy}"
    role = aws_iam_role.ecs_role.name
}
#AmazonECSTaskExecutionRolePolicy