variable "region" {}
variable "ami_id" {}
variable "instance_type" { 
  default = "t3.micro" 
}
variable "instance_count" { 
  default = 1 
}
variable "lambda_runtime" { 
  default = "python3.12" 
}
variable "start_cron" {}
variable "stop_cron" {}
