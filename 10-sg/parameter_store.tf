# resource "aws_ssm_parameter" "mysql_id" {
#   name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
#   type  = "String"
#   value = module.mysql_id.sg_id
# }

# create the parameter store and store the VPC id
# If the VPC id is not provided in main module output we cant access hehe in user module.. 
# we just give the CIDR for the VPC,VPC id is created after creating vpc. 


# resource "aws_ssm_parameter" "mysql-sg" {
#   name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
#   type  = "String"
#   value = module.mysql-sg.sg_id
# }


resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql_sg.sg_id
}

resource "aws_ssm_parameter" "backend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/backend_sg_id"
  type  = "String"
  value = module.backend_sg.sg_id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend_sg.sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion_sg.sg_id
}

resource "aws_ssm_parameter" "app_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/app_alb_sg_id"
  type  = "String"
  value = module.app_alb_sg.sg_id
}