variable "region" {}
variable "instance_type" { default = "t3.micro" }
variable "ami_id" {}
variable "instance_count" { default = 1 }
variable "start_cron" {
  description = "CloudWatch CRON for EC2 start (8AM IST: cron(30 2 * * ? *))"
}
variable "stop_cron" {
  description = "CloudWatch CRON for EC2 stop (5PM IST: cron(30 11 * * ? *))"
}
