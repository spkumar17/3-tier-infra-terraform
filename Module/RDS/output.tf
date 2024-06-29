output "MYSQL_URL" {
  value = aws_db_instance.db_instance.endpoint
}