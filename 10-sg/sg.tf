
# creating sg for mysql server
# module "alb-ingress-sg" {
#   source       = ""
#   project_name = "expense"
#   environment  = "dev"
#   description  = "security group for alb ingress"
#   app          = "back-alb"
#   vpc_id       = data.aws_ssm_parameter.vpc_id.value



# }


# # creating sg for backend server
# module "backend_sg" {
#     source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     vpc_id = data.aws_ssm_parameter.vpc_id.value
    
# }


# # creating sg for frontend server
# module "frontend_sg" {
#     source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     vpc_id = data.aws_ssm_parameter.vpc_id.value
    
# }


# # creating sg for bastion/jump hosts

# module "bastion_sg" {
#     source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     vpc_id = data.aws_ssm_parameter.vpc_id
    
# }


# creating security group for load balancer
module "alb-sg" {
  source       = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
  project_name = "expense"
  environment  = "dev"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name = "albsg" # i am unable to debug error so passing values through command prompt
  


}

# creating load balancer for bastion host
module "bastion_sg" {
  source       = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name     = "bastionsg"


}

#creating a security group rule for the loadbalancer to allow traffic from bastion host on post 80
resource "aws_security_group_rule" "alb-ingress-bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.alb-sg.sg_id
}


#creating security group rule for the  loadbalancer to allow traffic from bastion on port 443
resource "aws_security_group_rule" "alb-ingress-bastion-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.alb-ingress-sg.sg_id
}

# security group for mysql server
module "mysql_sg" {
    source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mysqlsg"
}



module "backend_sg" {
    source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "backendsg"
}


module "frontend_sg" {
    source = "git::https://github.com/pushpavathi-wq/Terraform.git//securitygroup_module?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "frontendsg"
}

# allowing the bastionhost as public instance,allowing traffic from internet
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}


# Allowing traffic to the mysql server from bastion host,with sg rule
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}


# Allowing traffic to the backend from load balancer
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}


#Allowing traffic to mysql from backend,defined in security group
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}



# Allowing traffic to load balancer from frontend in sg
resource "aws_security_group_rule" "app_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}



