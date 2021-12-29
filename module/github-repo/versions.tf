terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.5"
}

provider "github" {
  # token = var.github_token
  owner = var.owner
}
