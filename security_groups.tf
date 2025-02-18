resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Allow access to DB instance"
  vpc_id      = data.aws_vpc.main_vpc.id

 ingress {
  description     = "Allow EC2 instance to access RDS Database"
   from_port       = 5432
   to_port         = 5432
   protocol        = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

  # OUTBOUD CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}
