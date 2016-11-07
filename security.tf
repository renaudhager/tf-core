###############################
# Security groups Definitions #
###############################

# Security group for allow instance
resource "aws_security_group" "common" {
  name        = "${var.owner}_common"
  description = "Allow common traffic to instance"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow access from jump host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jump_host.id}"]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks     = ["${aws_vpc.default.cidr_block}"]
  }

  # Allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.owner}_common"
    owner = "${var.owner}"
  }
}

# Security group for access to Bastion
resource "aws_security_group" "jump_host" {
  name        = "${var.owner}_jump_host"
  description = "Allow all inbound traffic to jump host"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow SSH remote acces
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  tags {
    Name  = "${var.owner}_jump_host"
    owner = "${var.owner}"
  }
}

#
# Security group for puppetdb
#
resource "aws_security_group" "puppetdb" {
  name        = "${var.owner}_puppetdb"
  description = "Allow all inbound traffic to puppetdb  port"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow host to query puppetdb port
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  # Allow access to nginx port for puppetboard
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  # Allow access to nginx port for puppetboard
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  tags {
    Name  = "${var.owner}_puppetdb"
    owner = "${var.owner}"
  }
}

#
# Nginx
#
resource "aws_security_group" "nginx" {
  name        = "${var.owner}_nginx"
  description = "Allow all inbound traffic to nginx  instance"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow access to nginx
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  # Allow access to nginx
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  # Allow access to nginx
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ips}"]
  }

  tags {
    Name  = "${var.owner}_nginx"
    owner = "${var.owner}"
  }
}

#
# Consul
# TODO : put this in common SG
resource "aws_security_group" "consul" {
  name        = "${var.owner}_consul2"
  description = "Allow consul traffic to instance"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow consul traffic
  ingress {
    from_port = 8500
    to_port   = 8500
    protocol  = "tcp"
    cidr_blocks    = ["${var.allowed_ips}"]
  }
  ingress {
    from_port = 8400
    to_port   = 8400
    protocol  = "tcp"
    cidr_blocks    = ["${var.allowed_ips}"]
  }
  ingress {
    from_port = 8400
    to_port   = 8400
    protocol  = "tcp"
    cidr_blocks    = ["${var.allowed_ips}"]
  }
  ingress {
    from_port = 8300
    to_port   = 8305
    protocol  = "tcp"
    cidr_blocks    = ["${var.allowed_ips}"]
  }

  tags {
    Name  = "${var.owner}_consul2"
    owner = "${var.owner}"
  }

}

#
# Core ELB
#
resource "aws_security_group" "core_elb" {
  name        = "${var.owner}_core_elb"
  description = "Allow consul traffic to ELB"
  vpc_id      = "${aws_vpc.default.id}"

  # Allow HTTP traffic
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks    = ["${var.allowed_ips}"]
  }
  # Allow to outgoing connection.
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name  = "${var.owner}_core_elb"
    owner = "${var.owner}"
  }

}

# PUPPET DB RDS
resource "aws_security_group" "puppetdb_rds" {
  name        = "${var.owner}_puppet_puppetdb_rds"
  description = "Puppet DB RDS SG"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = ["${aws_security_group.puppetdb.id}"]
  }
}

#
# Outputs
#

output "sg_common" {
  value = "${aws_security_group.common.id}"
}
