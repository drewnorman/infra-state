variable "project_id" {
  description = "GCP project that owns the Terraform/OpenTofu state bucket."
  type        = string
}

variable "bucket_name" {
  description = "Globally unique Cloud Storage bucket name for Terraform/OpenTofu state."
  type        = string
  default     = "drew-infra-tofu-state"
}

variable "location" {
  description = "Cloud Storage bucket location. A single region keeps state storage simple and inexpensive."
  type        = string
  default     = "US-CENTRAL1"
}

variable "noncurrent_version_retention_days" {
  description = "Number of days to retain old state object versions."
  type        = number
  default     = 180

  validation {
    condition     = var.noncurrent_version_retention_days >= 30
    error_message = "Keep at least 30 days of old state object versions."
  }
}

variable "labels" {
  description = "Labels applied to the state bucket."
  type        = map(string)
  default = {
    managed_by = "opentofu"
    purpose    = "remote-state"
  }
}

variable "state_object_admin_members" {
  description = "Optional IAM members granted object admin access to the state bucket, for example user:name@example.com or serviceAccount:name@project.iam.gserviceaccount.com."
  type        = set(string)
  default     = []
}
