resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+"
}

resource "aws_secretsmanager_secret" "reggie_test_db_secret" {
  name        = "test-db-secret-2"
  description = "Secret containing database credentials"
}

resource "aws_secretsmanager_secret_version" "reggie_test_db_secret_version" {
  secret_id     = aws_secretsmanager_secret.reggie_test_db_secret.id
  secret_string = jsonencode({
    db_name     = "edu"
    db_password = random_password.db_password.result
    db_user     = "edu"
  })
}

data "aws_secretsmanager_secret" "rds_secret" {
  name = "rds!db-616b88f4-1107-41be-979e-f3e1a3cad049" # Adjust based on actual secret name format
}

resource "aws_secretsmanager_secret_rotation" "rds_rotation" {
  secret_id           = data.aws_secretsmanager_secret.rds_secret.id
#   rotation_lambda_arn = aws_lambda_function.db_rotation_lambda.arn  # You must define this Lambda separately

  rotation_rules {
    schedule_expression = "rate(8 hours)"
  }
}

# # Set up the automatic rotation (1-day interval, the minimum allowed)
# resource "aws_secretsmanager_secret_rotation" "db_secret_rotation" {
#   secret_id = data.aws_secretsmanager_secret.rds_secret.id

#   rotation_lambda_arn = data.aws_secretsmanager_secret.rds_secret.arn  # Lambda is optional for RDS automatic rotation
#   rotation_rules {
#     automatically_after_days = 1  # Rotation every 1 day (cannot be less than 1 day)
#   }
# }