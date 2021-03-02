<!--


  ** DO NOT EDIT THIS FILE
  **
  ** 1) Make all changes to `README.yaml`
  ** 2) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **


  -->

# terraform-github-repository

[![Build Status](https://travis-ci.org/hadenlabs/terraform-github-repository.svg?branch=main)](https://travis-ci.org/hadenlabs/terraform-github-repository) [![Latest Release](https://img.shields.io/github/release/hadenlabs/terraform-github-repository.svg)](https://travis-ci.org/hadenlabs/terraform-github-repository/releases)

Terraform module to provision an github repository.

---

This project is part of our comprehensive [hadenlabs](https://hadenlabs.com) modules of terraform.

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

```hcl

  module "main_with_pages" {
    source = "hadenlabs/repository/github"
    version = "0.7.2"

    providers = {
      github = github
    }

    name        = "repository-example-with-key"
    description = "github repository for repository"
    visibility  = "public"
    pages = {
      branch = "gh-pages"
      path = "/"
    }

    topics = [
        "go",
        "terraform",
    ]

    settings = {
      has_wiki               = true
      has_projects           = true
      vulnerability_alerts   = true
    }

```

Full working example can be found in [example](./example) folder.

## Examples

### common

```hcl

  module "main" {
      source = "hadenlabs/repository/github"
      version = "0.7.2"

      providers = {
        github = github
      }

      name        = "repository-example"
      description = "github repository for repository"
      visibility  = "public"
      settings = {
        auto_init              = true
        has_issues             = true
        has_wiki               = true
        has_projects           = true
    }
  }

```

### implement key deploy

```hcl

  module "main_with_key" {
    source = "hadenlabs/repository/github"
    version = "0.7.2"

    providers = {
      github = github
    }

    name        = "repository-example-with-key"
    description = "github repository for repository"
    visibility  = "public"
    deploy_keys = [{
      title = "user key"
      key = "/usr/etc/key/user.pub"
      read_only = false
    }]
  }

```

### implement secrets

```hcl

  module "main_with_secrets" {
    source = "hadenlabs/repository/github"
    version = "0.7.2"

    providers = {
      github = github
    }

    name        = "repository-example-with-key"
    description = "github repository for repository"
    visibility  = "public"
    secrets = {
      key= value
    }
  }
```

### implement pages

```hcl

  module "main_with_pages" {
    source = "hadenlabs/repository/github"
    version = "0.7.2"

    providers = {
      github = github
    }

    name        = "repository-example-with-key"
    description = "github repository for repository"
    visibility  = "public"
    pages = {
      branch = "gh-pages"
      path = "/"
    }

    topics = [
        "go",
        "terraform",
    ]

    settings = {
      has_wiki               = true
      has_projects           = true
      vulnerability_alerts   = true
    }
  }

```

### implement templates

```hcl

  module "main" {
      source = "hadenlabs/repository/github"
      version = "0.7.2"

      providers = {
        github = github
      }

      name        = "repository-example"
      description = "github repository for repository"
      visibility  = "public"
      settings = {
        auto_init              = true
        has_issues             = true
        has_wiki               = true
        has_projects           = true
      }

      pages = {
        owner = "owner-user"
        repository = "name-repository"
      }
  }

```

### implement collaborator

```hcl

  module "main" {
      source = "hadenlabs/repository/github"
      version = "0.7.2"

      providers = {
        github = github
      }

      name        = "repository-example"
      description = "github repository for repository"
      visibility  = "public"
      settings = {
        auto_init              = true
        has_issues             = true
        has_wiki               = true
        has_projects           = true
      }

      collaborators = [
      {
        username = "other-user"
        permission = "push"
      },
      ]
  }

```

 <!-- DO NOT EDIT. THIS FILE IS GENERATED BY THE MAKEFILE. -->

# Terraform variables

This document gives an overview of variables used in the platform of the terraform-github-repository.

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.14 |
| github    | >=4.5.0 |
| local     | >=1.3.0 |

## Providers

| Name   | Version |
| ------ | ------- |
| github | >=4.5.0 |

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | :-: |
| collaborators | List of Collaborator Objects | <pre>list(object({<br> username = string<br> permission = string<br> }))</pre> | `[]` | no |
| default_branch | Name of the Default Branch of the Repository | `string` | `"develop"` | no |
| deploy_keys | The name of repositories. | <pre>list(object({<br> title = string<br> key = string<br> read_only = bool<br> }))</pre> | `[]` | no |
| description | The description of the repository. | `string` | n/a | yes |
| name | The name of the repository. | `string` | n/a | yes |
| pages | Configuration block for GitHub Pages | `map(any)` | `{}` | no |
| secrets | secrets for repository | `map(any)` | `{}` | no |
| settings | Create and manage settings. | `map(any)` | `{}` | no |
| template | Template Repository to use when creating the Repository | `map(string)` | `{}` | no |
| topics | topics of project. | `list(string)` | `[]` | no |
| visibility | The visibility of the repository private or public. | `string` | `"private"` | no |

## Outputs

| Name       | Description                            |
| ---------- | -------------------------------------- |
| deploy_key | output instance deploy_key             |
| instance   | output instance repository             |
| secrets    | output instance github actions secrets |

## Help

**Got a question?**

File a GitHub [issue](https://github.com/hadenlabs/terraform-github-repository/issues), send us an [email][email] or join our [Slack Community][slack].

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/hadenlabs/terraform-github-repository/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://hadenlabs.com) with our other projects, we would love to hear from you! Shoot us an [email](mailto:support@hadenlabs.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

1.  **Fork** the repo on GitHub
2.  **Clone** the project to your own machine
3.  **Commit** changes to your own branch
4.  **Push** your work back up to your fork
5.  Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to rebase the latest changes from "upstream" before making a pull request!

### Versioning

Releases are managed using github release feature. We use \[Semantic Versioning\](<http://semver.org>) for all the releases. Every change made to the code base will be referred to in the release notes (except for cleanups and refactorings).

## Copyright

Copyright © 2018-2021 [Hadenlabs](https://hadenlabs.com)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Hadenlabs][https://hadenlabs.com]. Like it? Please let us know at <support@hadenlabs.com>

### Contributors

| [![Luis Mayta][luismayta_avatar]][luismayta_homepage]<br/>[Luis Mayta][luismayta_homepage] |
| ------------------------------------------------------------------------------------------ |

[luismayta_homepage]: https://github.com/luismayta
[luismayta_avatar]: https://github.com/luismayta.png?size=150
