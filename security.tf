# Security Group for WebApp EC2
resource "aws_security_group" "webapp_sg" {
  name        = "webapp-sg"
  description = "Allow traffic from NLB on port 8080"
  vpc_id      = aws_vpc.main.id

  # Allow Load Balancer (NLB) to reach port 8080
  ingress {
    description     = "Allow TCP 8080 from NLB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webapp-sg"
  }
}

# Security Group for MySQL
resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Allow only WebApp to access MySQL port 3306"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow MySQL from WebApp"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webapp_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-sg"
  }
}

# Security Group for Network Load Balancer
resource "aws_security_group" "nlb_sg" {
  name        = "nlb-sg"
  description = "Allow TCP 80 from Internet to NLB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nlb-sg"
  }
}
