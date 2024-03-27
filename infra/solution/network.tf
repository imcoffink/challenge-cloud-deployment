resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_block}"
}

resource "aws_subnet" "sn1" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet1_block}"
  availability_zone = "${var.aws_region}a"
}

resource "aws_subnet" "sn2" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet2_block}"
  availability_zone = "${var.aws_region}b"
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow inbound traffic from web"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
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
}

resource "aws_security_group" "allow_app" {
  name        = "allow_app"
  description = "Allow inbound traffic from app"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_network_interface.interface_tags.association[0].public_ip}/32"]
  }

  egress {
    from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

