<!-- Space: Projects -->
<!-- Parent: TerraformGithubRepository -->
<!-- Title: Examples TerraformGithubRepository -->

<!-- Label: Examples -->
<!-- Include: ./../disclaimer.md -->
<!-- Include: ac:toc -->

### common

```hcl
  module "main" {
      source = "hadenlabs/repository/github"
      version = "1.0.0"

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
    version = "1.0.0"

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
    version = "1.0.0"

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
    version = "1.0.0"

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
      version = "1.0.0"

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
      version = "1.0.0"

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

### implement with file

```hcl

  module "repository_file" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    description = "repository example"
    visibility  = "public"
    settings = {
      auto_init = true
    }
    files = [
        {
          branch              = "main"
          file                = "LICENSE"
          content             = file(format("%s/LICENSE", path.module))
          commit_message      = "ci: implement template"
          commit_author       = "@slovacus"
          commit_email        = "slovacus@gmail.com"
          overwrite_on_create = true
        },
    ]
  }

```

### implement with gitflow enabled

```hcl

  module "repository_file" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    is_git_flow = true
    description = "repository example"
    visibility  = "public"
    settings = {
      auto_init = true
    }
  }

```

### implement with topics and types

```hcl

  module "repository_file" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    description = "repository example"
    visibility  = "public"
    types  = ["django"]
    topics  = ["go"]
  }

```

### not implement labels default

```hcl

  module "repository_file" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    description = "repository example"
    visibility  = "public"
    add_labels_default = false
  }

```

### implement template

```hcl

  module "repository_file" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    description = "repository example"
    visibility  = "public"
    settings    = {
      template = {
        owner = "hadenlabs"
        repository = "terraform-github-repository"
      }
    }

  }

```

### implement branch protection

```hcl

  module "repository_branch_protection" {
    providers = {
      github = github
    }
    source      = "hadenlabs/repository/github"
    version     = "1.0.0"
    name        = "repository-example"
    description = "repository example"
    visibility  = "public"
    branch_protection    = {
      "develop" = {
        enforce_admins = true
        allows_deletions = false
      }
    }

  }

```
