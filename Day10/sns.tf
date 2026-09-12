resource "aws_sns_topic" "topic1" {
    name = "devops_team"
    depends_on = [ aws_autoscaling_group.asg1 ]
}
resource "aws_sns_topic_subscription" "topic_sub" {
    topic_arn = aws_sns_topic.topic1.arn
    protocol = "email"
    endpoint = "kajjayamsriram01@gmail.com"
    depends_on = [ aws_sns_topic.topic1  ]
}