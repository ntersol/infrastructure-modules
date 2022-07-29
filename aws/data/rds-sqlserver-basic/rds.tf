resource "aws_db_instance" "default" {
  allocated_storage     = 20
  engine                = "sqlserver-web"
  engine_version        = "15.00.4198.2.v1"
  instance_class        = "db.t3.small"
  username              = "admin"
  password              = var.db_instance_pass
  skip_final_snapshot   = true
  publicly_accessible   = true
  db_subnet_group_name  =  aws_db_subnet_group.subnet_group.id
  identifier            = "${var.name}-db"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.pub_subnets
}