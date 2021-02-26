locals {
  default_settings = {
    auto_init              = true
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

  settings = merge(local.default_settings, try(var.settings, {}))
  default_pages = {
    branch = var.default_branch
    path   = "/docs"
    cname  = ""
  }
  pages = merge(local.default_pages, var.pages)

}

resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  homepage_url           = local.settings.homepage_url
  has_issues             = local.settings.has_issues
  has_projects           = local.settings.has_projects
  has_wiki               = local.settings.has_wiki
  is_template            = local.settings.is_template
  allow_merge_commit     = local.settings.allow_merge_commit
  allow_squash_merge     = local.settings.allow_squash_merge
  allow_rebase_merge     = local.settings.allow_rebase_merge
  delete_branch_on_merge = local.settings.delete_branch_on_merge
  auto_init              = local.settings.auto_init
  gitignore_template     = local.settings.gitignore_template
  license_template       = local.settings.license_template
  archived               = local.settings.archived
  archive_on_destroy     = local.settings.archive_on_destroy
  vulnerability_alerts   = local.settings.vulnerability_alerts

  topics = var.topics

  pages {
    source {
      branch = local.pages.branch
      path   = local.pages.path
    }
    cname = local.pages.cname
  }

  lifecycle {
    prevent_destroy = true
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
  for_each        = var.secrets
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
  depends_on      = [github_repository.this]
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
  name        = "kind/documentation"
  description = "Categorizes issue or PR as related to documentation."
  color       = "5319e7"
}

resource "github_issue_label" "kind_feature" {
  repository  = github_repository.this.name
  name        = "kind/feature"
  description = "Categorizes issue or PR as related to a new feature."
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
