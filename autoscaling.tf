resource "aws_autoscaling_group" "webapp_asg" {
  name                      = "webapp-asg"
  desired_capacity          = 3
  max_size                  = 3
  min_size                  = 3
  vpc_zone_identifier       = [aws_subnet.public_subnet.id]
  health_check_type         = "EC2"
  health_check_grace_period = 30
  launch_template {
    id      = aws_launch_template.webapp_lt.id
    version = "$Latest"
  }

  # target group
  target_group_arns = [aws_lb_target_group.nlb_tg.arn]

  tag {
    key                 = "Name"
    value               = "webapp-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
