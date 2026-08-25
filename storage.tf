# Cloud Storage bucket for CloudNotes user uploads.
resource "google_storage_bucket" "cloudnotes_uploads" {
  name     = var.bucket_name
  location = var.region

  uniform_bucket_level_access = false

  force_destroy = true
}

# Access binding for the CloudNotes uploads bucket.
resource "google_storage_bucket_iam_member" "cloudnotes_uploads_reader" {
  bucket = google_storage_bucket.cloudnotes_uploads.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
