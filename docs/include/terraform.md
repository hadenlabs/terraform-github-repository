## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |
| github    | >=4.3.0 |

## Providers

| Name   | Version |
| ------ | ------- |
| github | >=4.3.0 |

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | :-: |
| description | The description of the repository. | `string` | n/a | yes |
| name | The name of the repository. | `string` | n/a | yes |
| key | filename pub for repository deploy key. | `string` | `""` | no |
| read_only | enabled read_only or no. | `bool` | `true` | no |
| visibility | The visibility of the repository private or public. | `string` | `"private"` | no |

## Outputs

| Name       | Description                |
| ---------- | -------------------------- |
| deploy_key | output instance deploy_key |
| instance   | output instance repository |
