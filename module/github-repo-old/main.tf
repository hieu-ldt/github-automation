# locals {
#   variables_processing = flatten([
#     for repo_name, attributes in var.repo_declaration : [
#       for teams in attributes.teams_with_admin_permission : {
#         repo_name     = repo_name
#         teams         = teams
#         template_name = attributes.template_name
#     }]
#   ])
#   repo_attributes = {
#     for repo_name, attributes in var.repo_declaration : repo_name => attributes
#   }
#   teams_attributes = {
#     for teams_attributes in local.variables_processing : "${teams_attributes.repo_name}.${teams_attributes.teams}" => teams_attributes
#   }
# }

# resource "github_repository" "this" {
#   for_each = var.my_repo_name

#   name        = each.key
#   description = "This repository is created base on template with the name ${each.value}"

#   visibility = var.visibility
#   template {
#     owner      = var.owner
#     repository = each.value
#   }
# }

resource "github_repository" "this" {
  name                   = var.repo_name
  description            = var.description
  visibility             = var.visibility
  delete_branch_on_merge = var.delete_branch_on_merge
  auto_init              = var.auto_init

  dynamic "template" {
    for_each = var.template_name != "" ? [1] : []
    content {
      owner      = var.owner
      repository = var.template_name
    }
  }
}

# resource "github_repository" "this" {
#   for_each = local.repo_attributes

#   name                   = each.key
#   description            = each.value.description
#   visibility             = var.visibility
#   delete_branch_on_merge = var.delete_branch_on_merge
#   auto_init              = var.auto_init

#   dynamic "template" {
#     for_each = each.value.template_name != "" ? [local.repo_attributes] : []
#     content {
#       owner      = var.owner
#       repository = each.value.template_name
#     }
#   }
# }

# data "github_team" "this" {
#   for_each = local.teams_attributes

#   slug = each.value.teams
# }

data "github_team" "this" {
  for_each = toset(var.teams_with_admin_permission)

  slug = each.value
}

# output "data" {
#   value = data.github_team.this
# }

# resource "github_team_repository" "this" {
#   for_each = local.teams_attributes

#   team_id    = data.github_team.this[each.key].id
#   repository = github_repository.this[each.value.repo_name].name
#   permission = var.permission

#   depends_on = [
#     data.github_team.this
#   ]
# }

resource "github_team_repository" "this" {
  for_each = toset(var.teams_with_admin_permission)

  team_id    = data.github_team.this[each.key].id
  repository = var.repo_name
  permission = var.permission
}

# resource "github_branch_protection_v3" "this" {
#   for_each = var.repo_declaration

#   repository     = github_repository.this[each.key].name
#   branch         = var.protected_branch
#   enforce_admins = var.enforce_admins

#   required_pull_request_reviews {
#     dismiss_stale_reviews      = var.dismiss_stale_reviews
#     require_code_owner_reviews = var.require_code_owner_reviews
#   }
# }

resource "github_branch_protection_v3" "this" {
  count = var.enable_branch_protection ? 1 : 0
  # for_each = var.repo_declaration

  repository     = var.repo_name
  branch         = var.protected_branch
  enforce_admins = var.enforce_admins

  required_pull_request_reviews {
    dismiss_stale_reviews      = var.dismiss_stale_reviews
    require_code_owner_reviews = var.require_code_owner_reviews
  }

  depends_on = [
    github_repository.this
  ]
}

# resource "github_repository" "list_repo_without_template" {
#   for_each = toset(var.my_repo_name_without_template)

#   name        = each.key
#   description = "This repository is created without any template"
#   auto_init   = var.auto_init

#   visibility  = var.visibility
#   is_template = false
# }
