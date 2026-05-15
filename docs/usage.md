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
    }

```

  Full working examples can be found in [examples](./examples) folder.