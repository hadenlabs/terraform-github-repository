locals {
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
  labels = yamldecode(file("${path.module}/data/labels.yaml"))
}

