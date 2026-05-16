resource "google_storage_bucket" "state" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  labels                      = var.labels

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      days_since_noncurrent_time = var.noncurrent_version_retention_days
      with_state                 = "ARCHIVED"
    }
  }
}

resource "google_storage_bucket_iam_member" "state_object_admin" {
  for_each = var.state_object_admin_members

  bucket = google_storage_bucket.state.name
  role   = "roles/storage.objectAdmin"
  member = each.value
}
