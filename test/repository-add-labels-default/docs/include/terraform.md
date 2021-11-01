<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >=4.5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_labels_default"></a> [add\_labels\_default](#input\_add\_labels\_default) | add labels defaults. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | description of repository. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | type of visibility. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | show instance module |
| <a name="output_labels"></a> [labels](#output\_labels) | show labels repository |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | show name repository |
<!-- END_TF_DOCS -->