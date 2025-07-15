# Conftest

[![Go Report Card](https://goreportcard.com/badge/open-policy-agent/opa)](https://goreportcard.com/report/open-policy-agent/conftest) [![Netlify](https://api.netlify.com/api/v1/badges/2d928746-3380-4123-b0eb-1fd74ba390db/deploy-status)](https://app.netlify.com/sites/vibrant-villani-65041c/deploys)

Conftest helps you write tests against structured configuration data. Using Conftest you can
write tests for your Kubernetes configuration, Tekton pipeline definitions, Terraform code,
Serverless configs or any other config files.

Conftest uses the Rego language from [Open Policy Agent](https://www.openpolicyagent.org/) for writing
the assertions. You can read more about Rego in [How do I write policies](https://www.openpolicyagent.org/docs/how-do-i-write-policies.html)
in the Open Policy Agent documentation.

Here's a quick example. Save the following as `policy/deployment.rego`:

```rego
package main

deny[msg] {
  input.kind == "Deployment"
  not input.spec.template.spec.securityContext.runAsNonRoot

  msg := "Containers must not run as root"
}

deny[msg] {
  input.kind == "Deployment"
  not input.spec.selector.matchLabels.app

  msg := "Containers must provide app label for pod selectors"
}
```

Assuming you have a Kubernetes deployment in `deployment.yaml` you can run Conftest like so:

```console
$ conftest test deployment.yaml
FAIL - deployment.yaml - Containers must not run as root
FAIL - deployment.yaml - Containers must provide app label for pod selectors

2 tests, 0 passed, 0 warnings, 2 failures, 0 exceptions
```

Conftest isn't specific to Kubernetes. It will happily let you write tests for any configuration files in a variety of different formats. See the [documentation](https://www.conftest.dev/) for [installation instructions](https://www.conftest.dev/install/) and
more details about the features.

## Want to contribute to Conftest?

* See [DEVELOPMENT.md](DEVELOPMENT.md) to build and test Conftest itself.
* See [CONTRIBUTING.md](CONTRIBUTING.md) to get started.

For discussions and questions join us on the [Open Policy Agent Slack](https://slack.openpolicyagent.org/)
in the `#opa-conftest` channel.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_lambda_start"></a> [lambda\_start](#module\_lambda\_start) | ./modules/lambda | n/a |
| <a name="module_lambda_stop"></a> [lambda\_stop](#module\_lambda\_stop) | ./modules/lambda | n/a |
| <a name="module_scheduler_start"></a> [scheduler\_start](#module\_scheduler\_start) | ./modules/scheduler | n/a |
| <a name="module_scheduler_stop"></a> [scheduler\_stop](#module\_scheduler\_stop) | ./modules/scheduler | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | variable "region" { type = string } | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t3.micro"` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | n/a | `string` | `"python3.9"` | no |
| <a name="input_start_cron"></a> [start\_cron](#input\_start\_cron) | n/a | `string` | n/a | yes |
| <a name="input_stop_cron"></a> [stop\_cron](#input\_stop\_cron) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instance_id"></a> [ec2\_instance\_id](#output\_ec2\_instance\_id) | n/a |
| <a name="output_lambda_start_arn"></a> [lambda\_start\_arn](#output\_lambda\_start\_arn) | n/a |
| <a name="output_lambda_stop_arn"></a> [lambda\_stop\_arn](#output\_lambda\_stop\_arn) | n/a |
<!-- END_TF_DOCS -->