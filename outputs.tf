output "bucket_name" {
  description = "Cloud Storage bucket name for remote state."
  value       = google_storage_bucket.state.name
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
