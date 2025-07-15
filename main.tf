provider "aws" {
  region = var.region
}

module "ec2" {
  source        = "./modules/mod-ec2"
  instance_type = var.instance_type
  ami_id        = var.ami_id
  instance_count = var.instance_count
}

module "iam" {
  source = "./modules/mod-iam"
}

module "lambda_start" {
  source          = "./modules/mod-lambda"
  function_name   = "start-ec2"
  handler         = "ec2_scheduler.lambda_handler"
  runtime         = "python3.12"
  lambda_role_arn = module.iam.lambda_role_arn
  ec2_instance_ids = module.ec2.instance_ids
  action_type      = "start"
}

module "lambda_stop" {
  source          = "./modules/mod-lambda"
  function_name   = "stop-ec2"
  handler         = "ec2_scheduler.lambda_handler"
  runtime         = "python3.12"
  lambda_role_arn = module.iam.lambda_role_arn
  ec2_instance_ids = module.ec2.instance_ids
  action_type      = "stop"
}

module "scheduler_start" {
  source              = "./modules/mod-scheduler"
  rule_name           = "start-ec2-rule"
  schedule_expression = var.start_cron
  lambda_function_arn = module.lambda_start.lambda_function_arn
  action_type         = "start"
  ec2_instance_ids    = module.ec2.instance_ids
}

module "scheduler_stop" {
  source              = "./modules/mod-scheduler"
  rule_name           = "stop-ec2-rule"
  schedule_expression = var.stop_cron
  lambda_function_arn = module.lambda_stop.lambda_function_arn
  action_type         = "stop"
  ec2_instance_ids    = module.ec2.instance_ids
}
