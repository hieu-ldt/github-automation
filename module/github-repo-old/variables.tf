variable "my_repo_name" {
  description = "Define the name of new repo and the template"
  type        = map(string)
  default = {
    #"Name-repo" = "name-template-repo"
    "card-service"                     = "some_template"
    "test-service"                     = "some_template"
    "payment-proxy-management-service" = "some_template"
  }
}

variable "repo_declaration" {
  type        = map(any)
  description = "Declare the name of new repo and its related attributes"
  default = {
    #   card-service = {
    #     description                 = ""
    #     template_name               = "some_template",
    #     teams_with_admin_permission = [],
    #   },
    #   test-service = {
    #     description                 = ""
    #     template_name               = "some_template",
    #     teams_with_admin_permission = [],
    #   }
    #   payment-proxy-management-service = {
    #     description                 = ""
    #     template_name               = "some_template",
    #     teams_with_admin_permission = [],
    #   }
  }
}

variable "my_repo_name_without_template" {
  description = "Define the name of new repo and the template"
  type        = set(string)
  default = [
    "k8s-apps-platform",
    "k8s-apps-microservices",
    "payment-service",
    "spacelift",
    "kafka-ops",
    "terraform-skeleton-vpc-apps",
    "terraform-dev-vpc-apps",
    "terraform-sandbox-vpc-apps",
    # "test",
  ]
}

# variable "description" {
#   description = "(Optional) A description of the repository."
#   type        = string
#   default     = "This repo has been created via Github Repo Automation powered by Cloud Platform DevOps POD."
# }

variable "visibility" {
  description = "(Optional) Can be public or private."
  type        = string
  default     = "public"
}

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged. Defaults to false."
  type        = bool
  default     = true
}

variable "auto_init" {
  description = "(Optional) Set to true to produce an initial commit in the repository."
  type        = bool
  default     = true
}

variable "github_token" {
  type      = string
  default   = "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"
  sensitive = true
}

variable "owner" {
  default = "hieu-ldt"
}

variable "permission" {
  description = "The permissions of team members regarding the repository"
  type        = string
  default     = "admin"
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

variable "enable_branch_protection" {
  description = "Choose if you want to enable branch protection function or not."
  type        = bool
  default     = true
}

variable "protected_branch" {
  type    = string
  default = "main"
}

variable "repo_name" {
  description = "(Required) The name of the repository."
  type        = string
}

variable "template_name" {
  description = "The name of the template repository."
  type        = string
  default     = ""
}

variable "teams_with_admin_permission" {
  description = "(Required) The GitHub team slug"
  type        = set(string)
  default     = []
}

variable "description" {
  description = "(Optional) A description of the repository."
  type        = string
}
