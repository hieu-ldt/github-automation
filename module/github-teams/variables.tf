variable "name" {
  description = "The name of the team."
  type        = string
  default     = ""
}

variable "description" {
  description = "A description of the team."
  type        = string
  default     = "This team has been created via Github Teams Automation powered by Cloud Platform DevOps POD."
}

variable "privacy" {
  description = "The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "closed"
}

variable "create_default_maintainer" {
  description = "Adds a default maintainer to the team"
  type        = bool
  default     = true
}

variable "team_role" {
  description = "Defaul role for members in this team"
  type        = string
  default     = "maintainer"
}

# variable "github_token" {
#   type      = string
#   default   = "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"
#   sensitive = true
# }

variable "owner" {
  default = "hieu-ldt"

}

variable "team_membership" {
  type    = map(list(string))
  default = {}
}

variable "team_name" {
  type = string
}

variable "team_members" {
  type = set(string)
}