# variable "project_name" {
#     default = "expense"
  
# }


# variable "environment" {
#     default = "dev"
  
# }


# variable "common_tags" {
#     default = {
#     project_name = "expense"
#     environment = "dev"
#     }
  
# }



variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z09655703QCDO6BLZJFRA"
}

variable "domain_name" {
    default = "daws82s.fun"
}