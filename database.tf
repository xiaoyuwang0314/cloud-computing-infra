resource "aws_instance" "mysql" {
  ami                         = var.mysql_ami_id
  instance_type               = var.instance_type
  availability_zone           = "us-east-2c"
  subnet_id                   = aws_subnet.private_subnet.id
  key_name                    = "deployer-key"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.mysql_sg.id]

  user_data = <<-EOF
      #!/bin/bash

      echo "Updating MySQL user permissions..."

      mysql -u root -p'${var.database_password}' -e "
        DROP USER IF EXISTS '${var.database_username}'@'%';
        CREATE USER '${var.database_username}'@'%' IDENTIFIED BY '${var.database_password}';
        GRANT ALL PRIVILEGES ON recommend.* TO '${var.database_username}'@'%';
        FLUSH PRIVILEGES;
      "
  EOF

  tags = {
    Name = "mysql-instance"
  }
}
