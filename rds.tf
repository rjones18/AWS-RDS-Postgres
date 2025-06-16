
resource "random_password" "rds_password" {
  length  = 20
  special = false
}

resource "aws_db_subnet_group" "database-subnet-group" {
  name        = "database subnets 2"
  subnet_ids  = [data.aws_subnet.data-a.id, data.aws_subnet.data-b.id]
  description = "Subnet for Database Instance"
  tags = {
    Name = "My DB subnet group"
  }
}

# ✅ Primary RDS Instance
resource "aws_db_instance" "database-instance" {
  allocated_storage             = 20
  storage_type                  = "gp2"
  engine                        = "postgres"
  engine_version                = "16.8"
  instance_class                = "db.t3.micro"
  identifier                    = "edu"
  db_name                       = "edu"
  username                      = "edu"
  password                      = random_password.rds_password.result
  multi_az                      = true
  db_subnet_group_name          = aws_db_subnet_group.database-subnet-group.name
  vpc_security_group_ids        = [aws_security_group.database-security-group.id]
  skip_final_snapshot           = true
  backup_retention_period       = 1
  publicly_accessible           = false
}


# ✅ Primary RDS Instance 2
resource "aws_db_instance" "database-instance2" {
  allocated_storage             = 20
  storage_type                  = "gp2"
  engine                        = "postgres"
  engine_version                = "16.8"
  instance_class                = "db.t3.micro"
  identifier                    = "edu2"
  db_name                       = "edu"
  username                      = "edu"
  password                      = random_password.rds_password.result
  multi_az                      = true
  db_subnet_group_name          = aws_db_subnet_group.database-subnet-group.name
  vpc_security_group_ids        = [aws_security_group.database-security-group.id]
  skip_final_snapshot           = true
  backup_retention_period       = 1
  publicly_accessible           = false
}


# # ✅ Read Replica (must use a different identifier)
# resource "aws_db_instance" "database-replica" {
#   replicate_source_db           = aws_db_instance.database-instance.arn
#   instance_class                = "db.t3.micro"
#   identifier                    = "edu-replica"
#   db_subnet_group_name          = aws_db_subnet_group.database-subnet-group.name
#   vpc_security_group_ids        = [aws_security_group.database-security-group.id]
#   publicly_accessible           = false
#   skip_final_snapshot           = true

#   # Ensure that settings like backup, storage, and engine match source
#   storage_type                  = "gp2"
#   engine                        = "postgres"
#   engine_version                = "16.3"

#   depends_on = [aws_db_instance.database-instance]
# }













