#
# ELB  Definitions
#

resource "aws_elb" "core-elb" {
  name    = "${var.owner}-core-elb"
  subnets = ["${aws_subnet.public.*.id}"]

  listener {
    instance_port      = 80
    instance_protocol  = "tcp"
    lb_port            = 80
    lb_protocol        = "tcp"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 10
  }

  instances                   = ["${aws_instance.nginx.*.id}"]
  security_groups             = ["${aws_security_group.core_elb.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

    tags {
      Name  = "core_elb"
      owner = "${var.owner}"
    }

}
