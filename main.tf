provider "github" {
  # token = var.github_token
  # owner = var.owner
}

# module "github-repo" {
#   source = "./module/github-repo/"
# }

module "github-teams" {
  for_each = var.team_membership
  source   = "./module/github-teams/"

  team_name    = each.key
  team_members = each.value
}

module "github-repo" {
  for_each = var.repo_declaration
  source   = "./module/github-repo-old/"

  repo_name                   = each.key
  description                 = each.value.description
  template_name               = each.value.template_name
  teams_with_admin_permission = each.value.teams_with_admin_permission

  depends_on = [
    module.github-teams
  ]
}
