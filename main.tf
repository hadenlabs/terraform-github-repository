locals {

  defaults = {
    topics = yamldecode(file("${path.module}/data/topics.yaml"))
    labels = yamldecode(file("${path.module}/data/labels.yaml"))
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
  }

  input = {
    settings           = try(var.settings, {})
    types              = try(var.types, [])
    topics             = try(var.topics, [])
    add_labels_default = try(var.add_labels_default, false)
  }

  generated_topics = flatten([
    for k in local.input.types : tolist(lookup(local.defaults.topics, k))
  ])

  generated_labels = tolist(lookup(local.defaults.labels, "labels"))

  outputs = {
    add_labels_default = local.input.add_labels_default
    settings           = merge(local.defaults.settings, local.input.settings)
    topics             = distinct(flatten(concat(local.generated_topics, local.input.topics)))
    labels             = local.generated_labels
  }

  default_pages = {
    branch = var.default_branch
    path   = "/"
    cname  = ""
  }

}

resource "github_repository" "this" {
  name        = var.name
  description = var.description
  #checkov:skip=CKV_GIT_1:The resource github is module
  visibility = var.visibility

  homepage_url           = local.outputs.settings.homepage_url
  has_issues             = local.outputs.settings.has_issues
  has_projects           = local.outputs.settings.has_projects
  has_wiki               = local.outputs.settings.has_wiki
  is_template            = local.outputs.settings.is_template
  allow_merge_commit     = local.outputs.settings.allow_merge_commit
  allow_squash_merge     = local.outputs.settings.allow_squash_merge
  allow_rebase_merge     = local.outputs.settings.allow_rebase_merge
  delete_branch_on_merge = local.outputs.settings.delete_branch_on_merge
  auto_init              = local.outputs.settings.auto_init
  gitignore_template     = local.outputs.settings.gitignore_template
  license_template       = local.outputs.settings.license_template
  archived               = local.outputs.settings.archived
  archive_on_destroy     = local.outputs.settings.archive_on_destroy
  vulnerability_alerts   = local.outputs.settings.vulnerability_alerts

  topics = var.topics

  dynamic "pages" {
    for_each = length(var.pages) != 0 ? [var.pages] : []

    content {
      source {
        branch = lookup(pages.value, "branch", local.default_pages.branch)
        path   = lookup(pages.value, "path", local.default_pages.path)
      }
      cname = lookup(pages.value, "cname", local.default_pages.cname)
    }
  }

  dynamic "template" {
    for_each = length(local.outputs.settings.template) != 0 ? [local.outputs.settings.template] : []

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
  count      = local.outputs.settings.has_projects ? 1 : 0
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
  count       = local.outputs.add_labels_default ? length(local.outputs.labels) : 0
  repository  = github_repository.this.name
  name        = lookup(local.outputs.labels[count.index], "name")
  description = lookup(local.outputs.labels[count.index], "description")
  color       = lookup(local.outputs.labels[count.index], "color")
}
