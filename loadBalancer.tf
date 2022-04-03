resource "aws_lb" "scandiALB" {
  name               = "ScandiALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allowWeb.id]
  subnets            = [aws_subnet.scandiSubnet.id]

  enable_deletion_protection = true

  tags = {
    Name = "Scandi Application Load Balancer"
  }
}

resource "aws_lb_target_group" "varnishTG" {
  name     = "varnishTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.scandiVpc.id
}

resource "aws_lb_target_group" "magentoTG" {
  name     = "magentoTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.scandiVpc.id
}

resource "aws_lb_target_group_attachment" "varnishAttachment" {
  target_group_arn = aws_lb_target_group.varnishTG.arn
  target_id        = aws_instance.scandiVarnish.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "magentoAttachment" {
  target_group_arn = aws_lb_target_group.magentoTG.arn
  target_id        = aws_instance.scandiMagento.id
  port             = 80
}

resource "aws_lb_listener" "frontendSecure" {
  load_balancer_arn = aws_lb.scandiALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:089272650682:certificate/423050ce-23cb-447b-862e-b50562a95003"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.varnishTG.arn
  }
}

resource "aws_lb_listener_rule" "staticToMagento" {
  listener_arn = aws_lb_listener.frontendSecure.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.magentoTG.arn
  }

  condition {
    path_pattern {
      values = ["/static/*", "/media/*"]
    }
  }

}

resource "aws_lb_listener" "frontendRedirectInsecure" {
  load_balancer_arn = aws_lb.scandiALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
