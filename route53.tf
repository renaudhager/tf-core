#
# ROUTE 53
#
resource "aws_route53_zone" "default" {
  name    = "${var.tld}"
  vpc_id  = "${aws_vpc.default.id}"

  tags {
    Name  = "${var.owner}_default"
    Owner = "${var.owner}"
  }
}

resource "aws_route53_record" "jump" {
  zone_id = "${aws_route53_zone.default.zone_id}"
  name    = "${var.vdc}-jump0${count.index+1}"
  type    = "A"
  ttl     = "${var.route53_ttl}"
  records = ["${aws_instance.jump.private_ip}"]
}

resource "aws_route53_record" "puppetdb" {
  zone_id = "${aws_route53_zone.default.zone_id}"
  name    = "${var.vdc}-puppetdb0${count.index+1}"
  type    = "A"
  ttl     = "${var.route53_ttl}"
  records = ["${aws_instance.puppetdb.private_ip}"]
}

resource "aws_route53_record" "nginx" {
  zone_id = "${aws_route53_zone.default.zone_id}"
  name    = "${var.vdc}-nginx0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.nginx.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}

#
# Outputs
#

output "default_route53_zone" {
  value = "${aws_route53_zone.default.zone_id}"
}
