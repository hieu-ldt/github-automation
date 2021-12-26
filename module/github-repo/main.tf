locals {
  repo_attributes = flatten([
    for repo_name, attributes in var.repo_declaration : [
      for teams in attributes.teams_with_admin_permission : {
        repo_name     = repo_name
        teams         = teams
        template_name = attributes.template_name
    }]
  ])
}

output "repo_attributes" {
  value = local.repo_attributes
}

locals {
  abc = {
    for idx, mx in local.repo_attributes : idx => mx
  }
  def = {
    for idx, mx in var.repo_declaration : idx => mx
  }
  ghi = {
    for attributes in local.repo_attributes : "${attributes.repo_name}.${attributes.teams}" => attributes
  }

  lmn = {
    for attributes in local.repo_attributes : "${attributes.repo_name}.${attributes.teams}" => attributes
  }
}

output "abc" {
  value = local.abc
}

output "def" {
  value = local.def
}

output "ghi" {
  value = local.ghi
}

output "lmn" {
  value = local.lmn
}

resource "github_repository" "this" {
  # for_each = {
  #   for idx, mx in var.repo_declaration : idx => mx
  # }
  for_each = var.repo_declaration

  name                   = each.key
  description            = var.description
  visibility             = var.visibility
  delete_branch_on_merge = var.delete_branch_on_merge
  auto_init              = var.auto_init

  template {
    owner      = var.owner
    repository = each.value.template_name != "" ? each.value.template_name : "blank_template"
  }
}

data "github_team" "this" {
  for_each = {
    for repo_attributes in local.repo_attributes : "${repo_attributes.repo_name}.${repo_attributes.teams}" => repo_attributes
  }

  slug = each.value.teams
}

# output "data" {
#   value = data.github_team.this
# }

resource "github_team_repository" "this" {
  for_each = {
    for repo_attributes in local.repo_attributes : "${repo_attributes.repo_name}.${repo_attributes.teams}" => repo_attributes
  }

  team_id    = data.github_team.this[each.key].id
  repository = github_repository.this[each.value.repo_name].name
  permission = var.permission

  depends_on = [
    data.github_team.this
  ]
}

resource "github_branch_protection_v3" "this" {
  # for_each = {
  #   for attributes in local.repo_attributes : "${attributes.repo_name}" => attributes...
  # }
  for_each = var.repo_declaration

  repository     = github_repository.this[each.key].name
  branch         = var.protected_branch
  enforce_admins = var.enforce_admins

  required_pull_request_reviews {
    dismiss_stale_reviews      = var.dismiss_stale_reviews
    require_code_owner_reviews = var.require_code_owner_reviews
  }
}




###################################
# variable "mx" {
#   default = {
#     "mywebsite.org." = {
#       ttl = "3600"
#       records = [
#         "home.mywebsite.org.",
#         "faq.mywebsite.org."
#       ]
#     }
#     "myotherwebsite.org." = {
#       ttl = "3600"
#       records = [
#         "home.myotherwebsite.org."
#       ]
#     }
#   }
# }

# locals {
#   mx_records = flatten([
#     for mx_key, mx in var.mx : [
#       for record in mx.records : {
#         mx_key = mx_key
#         record = record
#         ttl    = mx.ttl
#     }]
#   ])
# }

# output "mx_records" {
#   value = local.mx_records
# }

# locals {
#   qwe = { for idx, mx in local.mx_records : idx => mx }
#   rty = { for idx, mx in var.mx : idx => mx }

# }

# output "qwe" {
#   value = local.qwe
# }

# output "rty" {
#   value = local.rty
# }

###################################
# variable "team_membership" {
#   default = {
#     team_1 = [
#       # "AnhTran1610",
#       # "user-a",
#       # "user-b"
#     ],
#     team_2 = [
#       # "user-c",
#       # "user-d",
#       # "user-e"
#     ]
#   }
# }

# locals {
#   team_membership = flatten([
#     for teamName, teamMembers in var.team_membership : [
#       for member in teamMembers : {
#         team_name = teamName
#         member    = member
#       }
#     ]
#   ])
# }

# output "team_membership" {
#   value = local.team_membership
# }

# data "github_team" "that" {
#   for_each = var.team_membership

#   slug = each.key
# }

# output "github_team" {
#   value = data.github_team.that
# }
