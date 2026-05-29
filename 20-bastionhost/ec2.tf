resource "aws_instance" "instance1" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg.value] # get sg id from parameter store
    subnet_id = local.public_subnetid

    tags = {
  Name        = "${var.project_name}-${var.environment}-jumpserver"
  Project     = var.project_name
  Environment = var.environment
}
    

    }
