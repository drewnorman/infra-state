output "bucket_name" {
  description = "Cloud Storage bucket name for remote state."
  value       = google_storage_bucket.state.name
}

output "recipes_bucket_name" {
  description = "Cloud Storage bucket name for recipes remote state."
  value       = google_storage_bucket.recipes_state.name
}

output "homelab_backend_config" {
  description = "Backend configuration for this homelab root module."
  value = {
    bucket = google_storage_bucket.state.name
    prefix = "homelab/prod"
  }
}

output "homelab_backend_block" {
  description = "Backend block to add to the homelab root module after the bucket exists."
  value       = <<-EOT
    terraform {
      backend "gcs" {
        bucket = "${google_storage_bucket.state.name}"
        prefix = "homelab/prod"
      }
    }
  EOT
}

output "recipes_backend_config" {
  description = "Backend configuration for the recipes root module."
  value = {
    bucket = google_storage_bucket.recipes_state.name
    prefix = "prod"
  }
}

output "recipes_backend_block" {
  description = "Backend block to add to the recipes root module after the bucket exists."
  value       = <<-EOT
    terraform {
      backend "gcs" {
        bucket = "${google_storage_bucket.recipes_state.name}"
        prefix = "prod"
      }
    }
  EOT
}
