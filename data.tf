locals {
  data = {
    topics = {

      flask = [
        "python",
        "flask",
        "framework",
        "web-framework",
        "wsgi",
      ]

      django = [
        "python",
        "django",
        "web",
        "framework",
        "wsgi",
      ]

      docker = [
        "docker",
        "cli",
      ]

      go = [
        "go",
      ]

      ruby = [
        "ruby",
      ]

      nextjs = [
        "nextjs",
        "typescript",
      ]

      gatsbyjs = [
        "gatsbyjs",
      ]

      antd = [
        "antd",
      ]

      lua = [
        "lua",
      ]

      keras = [
        "python",
        "keras",
        "data-science",
        "machine-learning",
        "deep-learning",
        "tensorflow",
        "neural-networks",
      ]

      tensorflow = [
        "python",
        "tensorflow",
        "data-science",
        "machine-learning",
        "deep-learning",
        "neural-networks",
      ]

      nlp = [
        "data-science",
        "machine-learning",
        "deep-learning",
        "neural-networks",
      ]

      terraform = [
        "terraform",
        "hcl2",
        "iac",
      ]

      terraform-modules = [
        "terraform",
        "project",
        "hcl2",
        "iac",
      ]

      zsh = [
        "plugins",
        "zsh",
        "plugins",
      ]

      template = [
        "templates",
        "base",
      ]

      hammerspoon = [
        "hammerspoon",
        "lua",
      ]

      cookiecutter = [
        "cookiecutter",
        "python",
        "templates",
        "template",
        "tool",
        "generator",
      ]

      ansible-role = [
        "ansible",
        "ansible-role",
        "config-as-manager",
      ]

    }

    labels = [
      {
        name        = "kind/bug"
        description = "Categorizes issue or PR as related to a bug."
        color       = "FF0040"
      },
      {
        name        = "kind/discussion"
        description = "Categorizes issue or PR as related to a discussion."
        color       = "fbca04"
      },
      {
        name        = "kind/docs"
        description = "Categorizes issue or PR as related to documentation."
        color       = "5319e7"
      },
      {
        name        = "kind/feature"
        description = "Categorizes issue or PR as related to a new feature."
        color       = "1d76db"
      },
      {
        name        = "kind/refactor"
        description = "Categorizes issue or PR as related to a new refactor."
        color       = "1d76db"
      },
      {
        name        = "kind/perf"
        description = "Categorizes issue or PR as related to a new performance."
        color       = "1d76db"
      },
      {
        name        = "kind/chore"
        description = "Categorizes issue or PR as related to a new chore."
        color       = "1d76db"
      },
      {
        name        = "kind/question"
        description = "Categorizes issue or PR as related to a question."
        color       = "cc317c"
      },
      {
        name        = "priority/critical"
        description = "Highest priority. This should be dealt with ASAP."
        color       = "ee0701"
      },
      {
        name        = "priority/high"
        description = "After critical issues are fixed, these should be dealt with before any further issues."
        color       = "d93f0b"
      },
      {
        name        = "priority/medium"
        description = "This issue or PR may be useful, and needs some attention."
        color       = "fbca04"
      },
      {
        name        = "priority/low"
        description = "This issue can probably be picked up by anyone looking to contribute to the project."
        color       = "0e8a16"
      },
      {
        name        = "status/backlog"
        description = "Status Backlog."
        color       = "fbca04"
      },
      {
        name        = "status/todo"
        description = "Status Ready (to do)."
        color       = "fbca04"
      },
      {
        name        = "status/in_progress"
        description = "This issue or PR is being worked on, and has someone assigned."
        color       = "cccccc"
      },
      {
        name        = "status/review"
        description = "Status Review."
        color       = "fbca04"
      },
      {
        name        = "status/approved"
        description = "Status approved."
        color       = "c2e0c6"
      },
      {
        name        = "Done"
        description = "Status Done."
        color       = "fbca04"
      },
      {
        name        = "status/blocked"
        description = "There is another issue or PR not is possible resolved."
        color       = "ee0701"
      }
    ]
  }
}
