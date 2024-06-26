### Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_block}"
}

### Create 2 subnets in different AZs
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

### Security group to allow inbound traffic to the webserver
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

### Security group to allow inbound traffic only from within the subnets to the RDS instance
resource "aws_security_group" "allow_app" {
  name        = "allow_app"
  description = "Allow inbound traffic from app"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet1_block}","${var.subnet2_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Internet GW to allow the VPC to reach the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "Challenge VPC IG"
  }
}

### Route table to associate the IGW to the VPC
resource "aws_route_table" "vrt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "Challenge Route Table"
  }
}

### Route table association to associate the subnets to the route table
resource "aws_route_table_association" "srta1" {
  subnet_id      = "${aws_subnet.sn1.id}"
  route_table_id = "${aws_route_table.vrt.id}"
}

resource "aws_route_table_association" "srta2" {
  subnet_id      = "${aws_subnet.sn2.id}"
  route_table_id = "${aws_route_table.vrt.id}"
}

### DB Subnet group to assign the RDS instances to the subnets
resource "aws_db_subnet_group" "dbg" {
  name       = "challenge-db-subnet-group"
  subnet_ids = ["${aws_subnet.sn1.id}","${aws_subnet.sn2.id}"]

  tags = {
    Name = "Challenge DB Subnet Group"
  }
}
