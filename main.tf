locals {

  default = {
    topics                   = local.data.topics
    labels                   = local.data.labels
    branch_name_exclude_list = ["main", "develop", "/"]
    settings = {
      auto_init              = false
      has_issues             = true
      has_wiki               = true
      has_projects           = true
      homepage_url           = ""
      is_template            = false
      allow_merge_commit     = true
      allow_squash_merge     = true
      allow_rebase_merge     = true
      delete_branch_on_merge = false
      gitignore_template     = ""
      license_template       = ""
      archived               = false
      archive_on_destroy     = false
      vulnerability_alerts   = true
      template               = {}
    }

    pages = {
      branch = var.default_branch
      path   = "/"
      cname  = ""
    }

  }

  input = {
    settings           = try(var.settings, {})
    types              = try(var.types, [])
    topics             = try(var.topics, [])
    add_labels_default = try(var.add_labels_default, false)
    pages              = try(var.pages, {})
  }

  generated = {
    pages = try(local.input.pages, local.default.pages)
    topics = flatten([
      for k in local.input.types : tolist(lookup(local.default.topics, k))
    ])
    labels = local.default.labels
  }

  output = {
    add_labels_default = local.input.add_labels_default
    settings           = merge(local.default.settings, local.input.settings)
    topics             = distinct(flatten(concat(local.generated.topics, local.input.topics)))
    labels             = local.generated.labels
    pages              = local.generated.pages
  }

}

resource "github_repository" "this" {
  name        = var.name
  description = var.description
  #checkov:skip=CKV_GIT_1:The resource github is module
  visibility = var.visibility

  homepage_url           = local.output.settings.homepage_url
  has_issues             = local.output.settings.has_issues
  has_projects           = local.output.settings.has_projects
  has_wiki               = local.output.settings.has_wiki
  is_template            = local.output.settings.is_template
  allow_merge_commit     = local.output.settings.allow_merge_commit
  allow_squash_merge     = local.output.settings.allow_squash_merge
  allow_rebase_merge     = local.output.settings.allow_rebase_merge
  delete_branch_on_merge = local.output.settings.delete_branch_on_merge
  auto_init              = local.output.settings.auto_init
  gitignore_template     = local.output.settings.gitignore_template
  license_template       = local.output.settings.license_template
  archived               = local.output.settings.archived
  archive_on_destroy     = local.output.settings.archive_on_destroy
  vulnerability_alerts   = local.output.settings.vulnerability_alerts

  topics = var.topics

  dynamic "pages" {
    for_each = length(local.output.pages) != 0 ? [local.output.pages] : []

    content {
      source {
        branch = lookup(pages.value, "branch", local.default.pages.branch)
        path   = lookup(pages.value, "path", local.default.pages.path)
      }
      cname = lookup(pages.value, "cname", local.default.pages.cname)
    }
  }

  dynamic "template" {
    for_each = length(local.output.settings.template) != 0 ? [local.output.settings.template] : []

    content {
      owner      = lookup(template.value, "owner", null)
      repository = lookup(template.value, "repository", null)
    }
  }

  lifecycle {
    # prevent_destroy = true
    ignore_changes = [
      auto_init,
      has_issues,
      has_downloads,
      has_projects,
      has_wiki,
      is_template,
      vulnerability_alerts,
      description
    ]
  }
}

resource "github_branch" "gh_pages" {
  count      = !contains(local.default.branch_name_exclude_list, try(local.output.pages.branch, "/")) ? 1 : 0
  depends_on = [github_repository.this]
  repository = github_repository.this.name
  branch     = local.output.pages.branch

  lifecycle {
    ignore_changes = [
      branch,
      source_branch,
    ]
  }
}

resource "github_branch" "develop" {
  count      = var.is_git_flow ? 1 : 0
  depends_on = [github_repository.this]
  repository = github_repository.this.name
  branch     = "develop"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      branch,
      source_branch,
    ]
  }
}

resource "github_branch_default" "develop_default" {
  count = var.is_git_flow ? 1 : 0
  depends_on = [
    github_branch.develop,
    github_repository.this
  ]

  repository = github_repository.this.name
  branch     = "develop"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      branch,
    ]
  }

}

resource "github_repository_file" "this" {
  depends_on          = [github_repository.this]
  count               = length(var.files)
  repository          = github_repository.this.name
  branch              = var.files[count.index].branch
  file                = var.files[count.index].file
  content             = var.files[count.index].content
  commit_message      = var.files[count.index].commit_message
  commit_author       = var.files[count.index].commit_author
  commit_email        = var.files[count.index].commit_email
  overwrite_on_create = lookup(var.files[count.index], "overwrite_on_create", true)
  lifecycle {
    ignore_changes = [
      content,
      branch,
      commit_message
    ]
  }
}

resource "github_repository_project" "this" {
  depends_on = [github_repository.this]
  count      = local.output.settings.has_projects ? 1 : 0
  name       = lower(var.name)
  repository = github_repository.this.name
  body       = var.description
}

# Add a deploy key
resource "github_repository_deploy_key" "this" {
  depends_on = [github_repository.this]
  count      = length(var.deploy_keys)
  title      = var.deploy_keys[count.index].title
  repository = github_repository.this.name
  key        = file(var.deploy_keys[count.index].key)
  read_only  = lookup(var.deploy_keys[count.index], "read_only", true)
}

resource "github_actions_secret" "this" {
  depends_on      = [github_repository.this]
  for_each        = var.secrets
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_repository_collaborator" "this" {
  depends_on = [github_repository.this]
  count      = length(var.collaborators)

  repository                  = github_repository.this.name
  username                    = var.collaborators[count.index].username
  permission                  = lookup(var.collaborators[count.index], "permission", "push")
  permission_diff_suppression = lookup(var.collaborators[count.index], "permission_diff_suppression", false)
}

resource "github_issue_label" "this" {
  depends_on  = [github_repository.this]
  count       = local.output.add_labels_default ? length(local.output.labels) : 0
  repository  = github_repository.this.name
  name        = lookup(local.output.labels[count.index], "name")
  description = lookup(local.output.labels[count.index], "description")
  color       = lookup(local.output.labels[count.index], "color")
}
