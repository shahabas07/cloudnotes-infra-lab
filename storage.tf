# Cloud Storage bucket for CloudNotes user uploads.
resource "google_storage_bucket" "cloudnotes_uploads" {
  name     = var.bucket_name
  location = var.region

  uniform_bucket_level_access = true

  force_destroy = true

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }
}

# Access binding for the CloudNotes uploads bucket (service account only).
resource "google_storage_bucket_iam_member" "cloudnotes_uploads_reader" {
  bucket = google_storage_bucket.cloudnotes_uploads.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.cloudnotes_app.email}"
}
