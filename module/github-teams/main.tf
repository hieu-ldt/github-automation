resource "github_team" "this" {
  name                      = var.team_name
  description               = var.description
  privacy                   = var.privacy
  create_default_maintainer = var.create_default_maintainer
}

resource "github_team_membership" "this" {
  for_each = var.team_members

  team_id  = github_team.this.id
  username = each.value
  role     = var.team_role
}
