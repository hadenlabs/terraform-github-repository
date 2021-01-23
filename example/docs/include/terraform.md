## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >=0.13.0 |
| github    | >=2.9.2  |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | :-: |
| github | vars for github | <pre>object({<br> token = string<br> organization = string<br> })</pre> | n/a | yes |
| repository_name | The name of the repository. | `string` | n/a | yes |
| repository_description | description of repository. | `string` | `""` | no |

## Outputs

No output.
