resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t2.micro"
  db_name                 = "${var.app_db_name}"
  username             = "${var.app_db_user}"
  password             = "${var.app_db_password}"
  parameter_group_name = "default.postgres16"
  vpc_security_group_ids = ["${aws_security_group.allow_app.id}"]
}
