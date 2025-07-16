package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformBasic(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../", // Pointing to the root module
    Vars: map[string]interface{}{
      // Example: "bucket_name": "test-bucket-name"
    },
  }

  // At the end, destroy infra
  defer terraform.Destroy(t, terraformOptions)

  // Init and Apply
  terraform.InitAndApply(t, terraformOptions)

  // Example: check output variable (if you have one)
  // output := terraform.Output(t, terraformOptions, "bucket_id")
  // assert.NotEmpty(t, output)
}
