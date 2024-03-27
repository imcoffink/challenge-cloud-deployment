resource "aws_ecs_cluster" "cluster" {
  name = "challenge-container-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${aws_iam_role.ecs_execution_role.arn}"

  container_definitions = <<DEFINITION
[
  {
    "name": "${var.app_name}",
    "image": "${var.app_image}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "svc" {
  name                    = "${var.service_name}"
  cluster                 = "${aws_ecs_cluster.cluster.id}"
  task_definition         = "${aws_ecs_task_definition.app.arn}"
  desired_count           = 2
  launch_type             = "FARGATE"
  enable_ecs_managed_tags = true
  wait_for_steady_state   = true

  network_configuration {
    subnets          = ["${aws_subnet.sn1.id}","${aws_subnet.sn2.id}"]
    assign_public_ip = true
  }
}

data "aws_network_interface" "interface_tags" {
  filter {
    name   = "tag:aws:ecs:serviceName"
	values = ["${aws_ecs_service.svc.name}"]
  }
}
