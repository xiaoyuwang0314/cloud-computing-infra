resource "aws_launch_template" "webapp_lt" {
  name_prefix   = "webapp-lt-"
  image_id      = var.webapp_ami_id
  instance_type = var.instance_type
  key_name      = "deployer-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.webapp_sg.id]
    subnet_id                   = aws_subnet.public_subnet.id
  }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      set -e

      MYSQL_IP="${aws_instance.mysql.private_ip}"

      echo "Set environment variables"
      sudo sed -i '/DB_URL/d' /etc/environment
      sudo sed -i '/DB_USERNAME/d' /etc/environment
      sudo sed -i '/DB_PASSWORD/d' /etc/environment

      echo "export DB_URL=jdbc:mysql://$MYSQL_IP:3306/recommend?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true" | sudo tee -a /etc/environment
      echo "export DB_USERNAME=${var.database_username}" | sudo tee -a /etc/environment
      echo "export DB_PASSWORD=${var.database_password}" | sudo tee -a /etc/environment
      echo "export WEBAPP_SECRET_KEY=${var.webapp_secret_key}" | sudo tee -a /etc/environment
      sudo chmod 644 /etc/environment
      source /etc/environment

      sudo chown ubuntu:ubuntu /home/ubuntu/movie.jar
      chmod +x /home/ubuntu/movie.jar
      sudo touch /home/ubuntu/movie.log
      sudo chown ubuntu:ubuntu /home/ubuntu/movie.log
      sudo chmod 644 /home/ubuntu/movie.log
      sudo chown -R ubuntu:ubuntu /home/ubuntu/
      sudo chmod -R 755 /home/ubuntu/

      sudo pkill -f "movie.jar" || true
      echo "sleep before $(date)"
      sudo -u ubuntu nohup java -jar /home/ubuntu/movie.jar > /home/ubuntu/movie.log 2>&1 &
      echo "sleep after WebApp started successfully at $(date)"
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "webapp-instance"
    }
  }

  metadata_options {
    http_tokens   = "optional"
    http_endpoint = "enabled"
  }
}
