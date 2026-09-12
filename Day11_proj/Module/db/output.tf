output "db_endpoint" {
    value = aws_db_instance.mysql_db.address
}
output "db_name" {
  value = aws_db_instance.mysql_db.db_name
}
output "db_port" {
  value = aws_db_instance.mysql_db.port
}
output "db_pass" {
  value = aws_db_instance.mysql_db.password
  sensitive = true
}
output "usr_name" {
  value = aws_db_instance.mysql_db.username
}