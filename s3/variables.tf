variable "region" {
  description = "Target AWS region where everything will be placed"
  type        = string
  default     = "us-east-1"
}

variable "list_s3_objects" {
  description = "List of s3 objects"
  type        = set(string)
  default     = ["tmp-infra.tfstate", "tmp-github.tfstate"]
}
