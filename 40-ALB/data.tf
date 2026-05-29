data "aws_ssm_parameter" "alb_sg" {
  name = "/${var.project_name}/${var.environment}/alb_sg"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/private_subnet_ids"
  
}


data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}
