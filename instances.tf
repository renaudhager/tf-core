#
# JUMP HOST
#
resource "aws_instance" "jump" {
  ami                         = "${module.ami_ebs.ami_id}"
  instance_type               = "${var.instance_jump}"
  subnet_id                   = "${aws_subnet.public.0.id}"
  key_name                    = "rhager_tf"
  vpc_security_group_ids      = ["${aws_security_group.jump_host.id}", "${aws_security_group.common.id}"]
  user_data                   = "${template_file.jump_host.rendered}"
  associate_public_ip_address = true
  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
  tags {
    Name  = "${var.vdc}-jump0${count.index+1}"
    Owner = "${var.owner}"
  }
}

#
# PuppetDB
#
resource "aws_instance" "puppetdb" {
  ami                         = "${module.ami_ebs.ami_id}"
  instance_type               = "${var.instance_puppetdb}"
  subnet_id                   = "${aws_subnet.private.0.id}"
  key_name                    = "rhager_tf"
  vpc_security_group_ids      = ["${aws_security_group.common.id}", "${aws_security_group.puppetdb.id}"]
  user_data                   = "${template_file.puppetdb.rendered}"
  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
  tags {
    Name  = "${var.vdc}-puppetdb0${count.index+1}"
    Owner = "${var.owner}"
  }
}

#
# Nginx
#
resource "aws_instance" "nginx" {
  ami             = "${module.ami_ebs.ami_id}"
  instance_type   = "${var.instance_nginx}"
  subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
  key_name        = "rhager_tf"
  security_groups = [
    "${aws_security_group.common.id}",
    "${aws_security_group.nginx.id}",
    "${aws_security_group.consul.id}"
  ]
  user_data       = "${element(template_file.nginx.*.rendered, count.index)}"
  count           = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
  lifecycle {
    ignore_changes = ["ami", "security_groups", "user_data"]
  }
  tags {
    Name          = "${var.vdc}-nginx0${count.index+1}"
    Owner         = "${var.owner}"
  }
}
