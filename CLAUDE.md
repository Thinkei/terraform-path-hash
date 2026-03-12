# terraform-path-hash

## Purpose

Terraform module that generates a SHA256 content hash of a file or directory path, used to force re-deployments when file contents change.

## Stack

- Language: HCL (Terraform) + Python 3
- Runtime: Python 3 (invoked via `data.external`)

## Common Commands

```bash
terraform init    # Initialize module
terraform plan    # Preview changes
terraform apply   # Apply changes
```

## Architecture Constraints

- The `data.external` block in `main.tf` invokes `hash.py` via stdin/stdout JSON — any changes to `hash.py` must preserve the `{"path": ...}` input / `{"result": ...}` output contract
- Hash ignores dot-prefixed files and directories (e.g. `.git`) — intentional
- Hash includes relative file paths in the digest, not just contents — rename alone triggers a change

## Key Files

- `main.tf` — module inputs, `data.external` wiring, and output
- `hash.py` — SHA256 hashing logic invoked by Terraform

## Known Quirks

- Module uses `python3` explicitly — ensure `python3` is on PATH in the execution environment
- Hash is deterministic on file names + contents only; symlinks and permissions are not included

@auto-context.md
