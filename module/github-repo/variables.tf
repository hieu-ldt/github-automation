# variable "github_token" {
#   type      = string
#   default   = "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"
#   sensitive = true
# }

variable "owner" {
  default = "hieu-ldt"

}

variable "repo_declaration" {
  type        = map(any)
  description = "Declare the name of new repo and its related attributes"
  default = {
    marvel_repo = {
      template_name               = "some_template",
      teams_with_admin_permission = ["team_1"],
    },
    disney_repo = {
      template_name               = "",
      teams_with_admin_permission = ["team_1", "team_2"],
    }
  }
}

# variable "name" {
#   description = "(Required) The name of the repository."
#   type        = string
#   default     = ""
# }

variable "description" {
  description = "(Optional) A description of the repository."
  type        = string
  default     = "This repo has been created via Github Repo Automation powered by Cloud Platform DevOps POD."
}

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged. Defaults to false."
  type        = bool
  default     = true
}

# variable "template" {
#   description = "(Optional) Use a template repository to create this resource. See Template Repositories below for details."
#   type        = string
#   default     = "blank_template"
# }

variable "auto_init" {
  description = "(Optional) Set to true to produce an initial commit in the repository."
  type        = bool
  default     = true
}

variable "visibility" {
  description = "Set to private to make repo be private by default"
  type        = string
  default     = "public"
}

# variable "teams_with_admin_permission" {
#   type    = set(string)
#   default = []
# }

variable "permission" {
  description = "The permissions of team members regarding the repository"
  type        = string
  default     = "admin"
}

variable "protected_branch" {
  type    = string
  default = "main"
}

variable "enforce_admins" {
  type    = bool
  default = true
}

variable "dismiss_stale_reviews" {
  type    = bool
  default = true
}

variable "require_code_owner_reviews" {
  type    = bool
  default = true
}
