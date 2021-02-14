resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_wiki     = true
  has_projects = true
}

# Add a deploy key
resource "github_repository_deploy_key" "this" {
  count      = try(var.key, null) != null ? 1 : 0
  title      = var.name
  repository = github_repository.this.name
  key        = file(var.key)
  read_only  = var.read_only
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

resource "github_issue_label" "status_abandonned" {
  repository  = github_repository.this.name
  name        = "status/abandoned"
  description = "This issue or PR is no longer important."
  color       = "000000"
}

resource "github_issue_label" "status_available" {
  repository  = github_repository.this.name
  name        = "status/available"
  description = "No one has claimed responsibility for resolving this issue."
  color       = "c2e0c6"
}

resource "github_issue_label" "status_blocked" {
  repository  = github_repository.this.name
  name        = "status/blocked"
  description = "There is another issue or PR that needs to be resolved first."
  color       = "ee0701"
}

resource "github_issue_label" "status_in_progress" {
  repository  = github_repository.this.name
  name        = "status/in_progress"
  description = "This issue or PR is being worked on, and has someone assigned."
  color       = "cccccc"
}

resource "github_issue_label" "status_on_hold" {
  repository  = github_repository.this.name
  name        = "status/on_hold"
  description = "Similar to blocked, but is assigned to someone."
  color       = "e99695"
}

resource "github_issue_label" "status_proposal" {
  repository  = github_repository.this.name
  name        = "status/proposal"
  description = "A new propoal."
  color       = "d4c5f9"
}

resource "github_issue_label" "status_review_needed" {
  repository  = github_repository.this.name
  name        = "status/review_needed"
  description = "The issue or PR needs to be reviewed."
  color       = "fbca04"
}

resource "github_issue_label" "status_backlog" {
  repository  = github_repository.this.name
  name        = "Backlog"
  description = "Status Backlog."
  color       = "fbca04"
}

resource "github_issue_label" "status_ready" {
  repository  = github_repository.this.name
  name        = "Ready"
  description = "Status Ready."
  color       = "fbca04"
}

resource "github_issue_label" "status_working" {
  repository  = github_repository.this.name
  name        = "Working"
  description = "Status Working."
  color       = "fbca04"
}

resource "github_issue_label" "status_review" {
  repository  = github_repository.this.name
  name        = "Review"
  description = "Status Review."
  color       = "fbca04"
}

resource "github_issue_label" "status_done" {
  repository  = github_repository.this.name
  name        = "Done"
  description = "Status Done."
  color       = "fbca04"
}
