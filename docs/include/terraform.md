<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >=4.5.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >=1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >=4.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_branch.develop](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.develop_default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_issue_label.kind_bug](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_chore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_discussion](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_documentation](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_feature](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_perf](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_question](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.kind_refactor](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.priority_critical](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.priority_high](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.priority_low](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.priority_medium](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_approved](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_backlog](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_blocked](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_done](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_in_progress](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_ready](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_label.status_review](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_project.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_git_flow"></a> [is\_git\_flow](#input\_is\_git\_flow) | Git Flow - Github Flow | `bool` | `false` | no |
| <a name="input_files"></a> [files](#input\_files) | list files for repository | <pre>list(object({<br>    branch              = string<br>    file                = string<br>    content             = string<br>    commit_message      = string<br>    commit_author       = string<br>    commit_email        = string<br>    overwrite_on_create = bool<br>  }))</pre> | `[]` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | The name of repositories. | <pre>list(object({<br>    title     = string<br>    key       = string<br>    read_only = bool<br>  }))</pre> | `[]` | no |
| <a name="input_collaborators"></a> [collaborators](#input\_collaborators) | List of Collaborator Objects | <pre>list(object({<br>    username   = string<br>    permission = string<br>  }))</pre> | `[]` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | topics of project. | `list(string)` | `[]` | no |
| <a name="input_types"></a> [types](#input\_types) | types of project. | `list(string)` | `[]` | no |
| <a name="input_pages"></a> [pages](#input\_pages) | Configuration block for GitHub Pages | `map(any)` | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | secrets for repository | `map(any)` | `{}` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Create and manage settings. | `map(any)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | Template Repository to use when creating the Repository | `map(string)` | `{}` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | Name of the Default Branch of the Repository | `string` | `"develop"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the repository. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The visibility of the repository private or public. | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deploy_key"></a> [deploy\_key](#output\_deploy\_key) | output instance deploy\_key |
| <a name="output_files"></a> [files](#output\_files) | output instance github files |
| <a name="output_instance"></a> [instance](#output\_instance) | output instance repository |
| <a name="output_name"></a> [name](#output\_name) | output name repository |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | output instance github actions secrets |
| <a name="output_topics"></a> [topics](#output\_topics) | output topics github repository |
<!-- END_TF_DOCS -->