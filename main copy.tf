resource "aws_launch_template" "demo" {
  name_prefix            = local.name_prefix
  image_id               = local.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  user_data              = filebase64("${path.root}/user-data.sh")
  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }
}

resource "aws_autoscaling_group" "demo" {
  desired_capacity    = local.count
  max_size            = local.count
  min_size            = local.count
  target_group_arns   = [aws_lb_target_group.demo.arn]
  vpc_zone_identifier = module.vpc.private_subnets

  launch_template {
    id      = aws_launch_template.demo.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = var.custom_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}