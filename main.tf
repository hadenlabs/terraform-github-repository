locals {

  defaults = {
    topics = yamldecode(file("${path.module}/data/topics.yaml"))
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
    }
  }

  input = {
    settings = try(var.settings, {})
    types    = try(var.types, [])
    topics   = try(var.topics, [])
  }

  generated_topics = flatten([
    for k in local.input.types : tolist(lookup(local.defaults.topics, k))
  ])

  outputs = {
    settings = merge(local.defaults.settings, local.input.settings)
    topics   = distinct(flatten(concat(local.generated_topics, local.input.topics)))
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
    for_each = length(var.template) != 0 ? [var.template] : []

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
  count = var.is_git_flow ? 1 : 0

  repository = github_repository.this.name
  branch     = "develop"

  depends_on = [github_repository.this]
}

resource "github_branch_default" "develop_default" {
  count = var.is_git_flow ? 1 : 0

  repository = github_repository.this.name
  branch     = "develop"

  depends_on = [
    github_branch.develop,
    github_repository.this
  ]
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

resource "github_issue_label" "kind_bug" {
  repository  = github_repository.this.name
  name        = "kind/bug"
  description = "Categorizes issue or PR as related to a bug."
  color       = "FF0040"
}

resource "github_issue_label" "kind_discussion" {
  repository  = github_repository.this.name
  name        = "kind/discussion"
  description = "Categorizes issue or PR as related to a discussion."
  color       = "fbca04"
}

resource "github_issue_label" "kind_documentation" {
  repository  = github_repository.this.name
  name        = "kind/docs"
  description = "Categorizes issue or PR as related to documentation."
  color       = "5319e7"
}

resource "github_issue_label" "kind_feature" {
  repository  = github_repository.this.name
  name        = "kind/feature"
  description = "Categorizes issue or PR as related to a new feature."
  color       = "1d76db"
}

resource "github_issue_label" "kind_refactor" {
  repository  = github_repository.this.name
  name        = "kind/refactor"
  description = "Categorizes issue or PR as related to a new refactor."
  color       = "1d76db"
}

resource "github_issue_label" "kind_perf" {
  repository  = github_repository.this.name
  name        = "kind/perf"
  description = "Categorizes issue or PR as related to a new performance."
  color       = "1d76db"
}

resource "github_issue_label" "kind_chore" {
  repository  = github_repository.this.name
  name        = "kind/chore"
  description = "Categorizes issue or PR as related to a new chore."
  color       = "1d76db"
}

resource "github_issue_label" "kind_question" {
  repository  = github_repository.this.name
  name        = "kind/question"
  description = "Categorizes issue or PR as related to a question."
  color       = "cc317c"
}

resource "github_issue_label" "priority_critical" {
  repository  = github_repository.this.name
  name        = "priority/critical"
  description = "Highest priority. This should be dealt with ASAP."
  color       = "ee0701"
}

resource "github_issue_label" "priority_high" {
  repository  = github_repository.this.name
  name        = "priority/high"
  description = "After critical issues are fixed, these should be dealt with before any further issues."
  color       = "d93f0b"
}

resource "github_issue_label" "priority_medium" {
  repository  = github_repository.this.name
  name        = "priority/medium"
  description = "This issue or PR may be useful, and needs some attention."
  color       = "fbca04"
}

resource "github_issue_label" "priority_low" {
  repository  = github_repository.this.name
  name        = "priority/low"
  description = "This issue can probably be picked up by anyone looking to contribute to the project."
  color       = "0e8a16"
}

resource "github_issue_label" "status_backlog" {
  repository  = github_repository.this.name
  name        = "status/backlog"
  description = "Status Backlog."
  color       = "fbca04"
}

resource "github_issue_label" "status_ready" {
  repository  = github_repository.this.name
  name        = "status/todo"
  description = "Status Ready (to do)."
  color       = "fbca04"
}

resource "github_issue_label" "status_in_progress" {
  repository  = github_repository.this.name
  name        = "status/in_progress"
  description = "This issue or PR is being worked on, and has someone assigned."
  color       = "cccccc"
}

resource "github_issue_label" "status_review" {
  repository  = github_repository.this.name
  name        = "status/review"
  description = "Status Review."
  color       = "fbca04"
}

resource "github_issue_label" "status_approved" {
  repository  = github_repository.this.name
  name        = "status/approved"
  description = "status approved."
  color       = "c2e0c6"
}

resource "github_issue_label" "status_done" {
  repository  = github_repository.this.name
  name        = "Done"
  description = "Status Done."
  color       = "fbca04"
}

resource "github_issue_label" "status_blocked" {
  repository  = github_repository.this.name
  name        = "status/blocked"
  description = "There is another issue or PR not is possible resolved."
  color       = "ee0701"
}
