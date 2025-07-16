package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformBasic(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../", // or "." depending on your repo structure
    }

    defer terraform.Destroy(t, terraformOptions)

    terraform.InitAndApply(t, terraformOptions)
    // Example: check output variable (if you have one)
  // output := terraform.Output(t, terraformOptions, "bucket_id")
  // assert.NotEmpty(t, output)
    // Dummy assertion, always passes
    assert.Equal(t, 1, 1)
}
