<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >=4.3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../ |  |
| <a name="module_main_with_key"></a> [main\_with\_key](#module\_main\_with\_key) | ../ |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github"></a> [github](#input\_github) | vars for github | <pre>object({<br>    token        = string<br>    owner = string<br>  })</pre> | n/a | yes |
| <a name="input_repository_description"></a> [repository\_description](#input\_repository\_description) | description of repository. | `string` | `""` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the repository. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->