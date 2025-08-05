resource "aws_instance" "my_public_server" {
  count                  = 1
  ami                    = "ami-0be5f59fbc80d980c"
  instance_type          = "t2.small"
  subnet_id              = data.aws_subnet.data-a.id
  vpc_security_group_ids = [aws_security_group.database-security-group.id]
  key_name               = "newkey"
  iam_instance_profile = "_EC2_SSM"

  tags = {
    Name = "bastion_server_${count.index + 1}"
  }

}