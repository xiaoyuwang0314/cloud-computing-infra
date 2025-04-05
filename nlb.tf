resource "aws_lb" "nlb" {
  name               = "api-nlb"
  load_balancer_type = "network"
  internal           = false
  subnets            = [aws_subnet.public_subnet.id]
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.nlb_sg.id]

  tags = {
    Name = "nlb"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name        = "nlb-tg"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"
    port                = "8080"
    path                = "/v1/healthcheck"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 4
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "nlb-tg"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}
