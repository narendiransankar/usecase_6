variable "region" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "instance_type" { 
  default = "t3.micro" 
}
variable "instance_count" { 
  default = 1 
}
variable "lambda_runtime" { 
  default = "python3.12" 
}
variable "start_cron" {
  type = string
}
variable "stop_cron" {
  type = string
}
