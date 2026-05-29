# vpc id stored in parameter store,pull it using data sources

data "aws_ssm_parameter" "bastion_sg" {
  name = "/${var.project_name}/${var.environment}/bastion_sg"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
}