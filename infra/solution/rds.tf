### RDS instance configuration - PostgreSQL 16.1
resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.m5d.large"
  db_subnet_group_name   = "${aws_db_subnet_group.dbg.name}"
  db_name                = "${var.app_db_name}"
  username               = "${var.app_db_user}"
  password               = "${var.app_db_password}"
  parameter_group_name   = "default.postgres16"
  vpc_security_group_ids = ["${aws_security_group.allow_app.id}"]
  skip_final_snapshot    = true
}
