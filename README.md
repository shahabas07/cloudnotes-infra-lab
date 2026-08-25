# CloudNotes Infra Lab

Terraform Infrastructure-as-Code for **CloudNotes**, a simple web app running on
Google Cloud Platform. This repo is a **debugging exercise** for the Cloud
Computing module on GCP **networking, IAM, and storage security**.

> ⚠️ **This repository is intentionally insecure.** It contains **exactly three
> planted security misconfigurations** for you to find and fix. The code
> `terraform validate`s cleanly as-is — the faults are security/config problems,
> not syntax errors.

## Layout

| File | Purpose |
|---|---|
| `main.tf` | Provider block and shared config |
| `variables.tf` | Input variables (project, region, CIDRs, bucket name) |
| `network.tf` | VPC network, subnet, firewall rule |
| `iam.tf` | CloudNotes app service account + IAM binding |
| `storage.tf` | Cloud Storage bucket for uploads |

## How to work with this repo

You only ever **review and validate** this code. **Never run `terraform apply`** —
grading needs no billing account or live GCP project.

```bash
terraform init
terraform validate   # should succeed before and after your fixes
terraform fmt -check
terraform plan        # optional: review planned changes
```

## Intended secure design

Your fixes should bring the infrastructure in line with the following intended
design:

### Networking / firewall
- Only **HTTP (80)** and **HTTPS (443)** are open to the public internet
  (`0.0.0.0/0`).
- **SSH (22)** is restricted to a trusted administrative CIDR
  (`var.trusted_ssh_cidr`), never the whole internet.
- The **database port (5432)** is **not** exposed publicly — it stays private
  within the VPC.

### IAM / least privilege
- The CloudNotes app service account is granted **only the narrow role it
  actually needs** (e.g. `roles/storage.objectViewer`).
- It must **not** hold broad roles such as `roles/owner` or `roles/editor`.

### Storage security
- The uploads bucket is **private** — no `allUsers` (public) access.
- **Uniform bucket-level access** is enabled (`uniform_bucket_level_access = true`).
- A **lifecycle rule** manages object retention (e.g. delete or transition
  objects after N days).

## The three issues to fix

1. **Firewall / network security** — an over-open firewall rule exposes sensitive
   ports to the entire internet.
2. **IAM least privilege** — the app service account is over-privileged.
3. **Storage security** — the uploads bucket is public and lacks lifecycle
   management.
