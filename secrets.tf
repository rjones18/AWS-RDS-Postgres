# resource "random_password" "db_password" {
#   length           = 16
#   special          = true
#   override_special = "!@#$%^&*()-_=+"
# }

# resource "aws_secretsmanager_secret" "reggie_test_db_secret" {
#   name        = "test-db-secret"
#   description = "Secret containing database credentials"
# }

# resource "aws_secretsmanager_secret_version" "reggie_test_db_secret_version" {
#   secret_id     = aws_secretsmanager_secret.reggie_test_db_secret.id
#   secret_string = jsonencode({
#     db_name     = "edu"
#     db_password = random_password.db_password.result
#     db_user     = "edu"
#   })
# }