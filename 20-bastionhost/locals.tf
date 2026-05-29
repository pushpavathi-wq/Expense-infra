locals {
  
public_subnetid = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

}