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

# Ingress firewall rule for HTTP/HTTPS traffic (public).
resource "google_compute_firewall" "cloudnotes_web_ingress" {
  name    = "cloudnotes-allow-web"
  network = google_compute_network.cloudnotes_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["cloudnotes-app"]
}

# Ingress firewall rule for SSH (restricted to trusted CIDR).
resource "google_compute_firewall" "cloudnotes_ssh_ingress" {
  name    = "cloudnotes-allow-ssh"
  network = google_compute_network.cloudnotes_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.trusted_ssh_cidr]
  target_tags   = ["cloudnotes-app"]
}
