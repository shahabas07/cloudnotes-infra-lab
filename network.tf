# VPC network for CloudNotes.
resource "google_compute_network" "cloudnotes_vpc" {
  name                    = "cloudnotes-vpc"
  auto_create_subnetworks = false
}

# Subnet hosting the CloudNotes app instances.
resource "google_compute_subnetwork" "cloudnotes_subnet" {
  name          = "cloudnotes-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.cloudnotes_vpc.id
}

# Ingress firewall rule for the CloudNotes app.
resource "google_compute_firewall" "cloudnotes_ingress" {
  name    = "cloudnotes-allow-ingress"
  network = google_compute_network.cloudnotes_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "5432"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["cloudnotes-app"]
}
