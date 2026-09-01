This document details the three vulnerabilities that were identified and fixed in the CloudNotes infrastructure.

---
## 1. Firewall / Network Security Issue 

### **Fix Applied:**
Split the single overly-permissive firewall rule into two separate rules:

1. **`cloudnotes_web_ingress`** - Public web traffic (ports 80, 443 from 0.0.0.0/0)
2. **`cloudnotes_ssh_ingress`** - Restricted SSH access (port 22 from var.trusted_ssh_cidr)
3. **Database port 5432** - Completely removed from firewall rules (stays private within VPC)

---

## 2. IAM Least Privilege Violation 

### **Fix Applied:**
Changed the role from `roles/owner` to `roles/storage.objectViewer`:
- Grants only read access to Cloud Storage objects
- Aligns with app's actual needs (reading uploads)
- Follows least privilege principle

---

## 3. Storage Security Issues 

### **Fix Applied:**
1. **Removed public access**: Changed from `allUsers` to service account only
2. **Enabled uniform bucket-level access**: Set to `true` for simplified IAM
3. **Added lifecycle rule**: Automatically delete objects after 90 days

---

```

