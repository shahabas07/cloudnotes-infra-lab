variable "project" {
  description = "GCP project ID for the CloudNotes app (placeholder — set your own)."
  type        = string
  default     = "cloudnotes-demo-project"
}

variable "region" {
  description = "GCP region to deploy CloudNotes resources into."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone within the region."
  type        = string
  default     = "us-central1-a"
}

variable "trusted_ssh_cidr" {
  description = "CIDR range trusted for SSH administration (e.g. office/VPN)."
  type        = string
  default     = "203.0.113.0/24"
}

variable "bucket_name" {
  description = "Globally-unique name for the CloudNotes uploads bucket."
  type        = string
  default     = "cloudnotes-uploads-demo"
}
