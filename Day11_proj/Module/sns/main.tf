resource "aws_sns_topic" "sns" {
    name = var.sns_name
}
resource "aws_sns_topic_subscription" "sn_sub" {
    topic_arn = aws_sns_topic.sns.arn
    protocol = "email"
    endpoint = "kajjayamsriram01@gmail.com"
}