resource "aws_db_instance" "default" {
  allocated_storage     = 20
  engine                = "sqlserver-web"
  engine_version        = var.eng_ver
  instance_class        = var.inst_size
  username              = "admin"
  password              = var.db_instance_pass
  skip_final_snapshot   = true
  publicly_accessible   = true
  db_subnet_group_name  =  aws_db_subnet_group.subnet_group.id
  identifier            = "${var.name}-db"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnets
}