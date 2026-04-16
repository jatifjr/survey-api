# terraform-oci-ampere

Simple OCI Ampere A1 Terraform stack for Ubuntu.

Defaults are production-safe for OCI Free Tier Arm and can be changed via local variables.

## Minimal local workflow

1. Create your local vars file from the example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit local-only `terraform.tfvars`.
3. Run from `infra/`:

```bash
cd infra
terraform init
terraform plan
terraform apply -auto-approve
```

No extra `-var-file` flags are required for the default local flow.

## Files

- `providers.tf` - Terraform/provider config
- `variables.tf` - all inputs
- `main.tf` - data sources, locals, and resources
- `outputs.tf` - outputs
- `terraform.tfvars.example` - safe template committed to git
- `terraform.tfvars` - runtime configuration (ignored, local only)
- `cloud-init/base.yaml.tpl` - default Ubuntu cloud-init (nftables host firewall)

## Required input

- `compartment_ocid`
- `ssh_public_key`

## Important knobs in `terraform.tfvars`

- `name_prefix` - unified naming for all resources
- `ubuntu_version` - Ubuntu version selection (default `24.04`)
- `region` - optional override; if omitted, local OCI config/environment decides

## Notes

- Shape defaults to `VM.Standard.A1.Flex`.
- OCI security list allows only TCP `22`, `80`, and `443`.
- The VM uses the `ssh_public_key` you provide in local vars.
- `cloud-init/base.yaml.tpl` applies simple SSH hardening (`PermitRootLogin no`, password auth disabled) and configures `nftables` to allow only SSH/HTTP/HTTPS inbound.
- Instance-level firewall is configured with `nftables` in `cloud-init/base.yaml.tpl` (no UFW).

## GitHub Actions CI (Optional Infra Path)

This repo uses `.github/workflows/ci.infra.yml` for optional Terraform checks:

- `terraform fmt -check -recursive -diff`
- `terraform init -backend=false -input=false`
- `terraform validate`
- `tflint --init` and `tflint --recursive`

This workflow is intentionally **plan/apply-free** and only runs for `infra/**` changes (or manual trigger), so infra remains optional and does not become the main delivery path.

Real plan/apply authority should remain manual or be handled in a dedicated Terraform/HCP pipeline when needed.

## Secrets management (strict)

Never store sensitive values in tracked files.

### Local development

- Keep real values only in ignored files (`terraform.tfvars`, `.env`, OCI key files).
- Never commit private keys (`*.pem`, `*.key`) or OCI config directories (`.oci/`).
- Prefer environment variables for provider auth in local sessions:
  - `TF_VAR_tenancy_ocid`
  - `TF_VAR_user_ocid`
  - `TF_VAR_fingerprint`
  - `TF_VAR_private_key_path`
  - `TF_VAR_region`
- If local secrets leak, rotate credentials immediately.

### GitHub repository settings

Use GitHub Actions secrets instead of committing secrets:

1. Open **Repository Settings > Secrets and variables > Actions**.
2. Add required secrets (if you later wire HCP or remote plan jobs).
3. Never echo secrets in scripts and avoid debug traces that print env vars.

### CI preflight checklist

- Push a branch/PR touching `infra/**`.
- Confirm `CI Infra` workflow passes `fmt`, `validate`, and `tflint` when `infra/**` changes.
- Keep `terraform apply` manual and out of CI unless you intentionally add a separate controlled workflow.

## HCP Terraform setup guide

### 1) Create workspace (VCS-driven recommended)

1. In HCP Terraform, create or pick an organization.
2. Create a workspace and choose **Version Control Workflow**.
3. Connect your GitHub repository and select the target branch.
4. Set workspace **Working Directory** to repo root (or specific subdir if you move code later).
5. Queue one initial run manually in HCP (required for new VCS workspaces).

### 2) Configure workspace variables

Set these as Terraform variables in HCP workspace (mark sensitive where appropriate):

- `compartment_ocid`
- `tenancy_ocid` (sensitive)
- `user_ocid` (sensitive)
- `fingerprint` (sensitive)
- `region`
- `ssh_public_key` (not secret)
- `private_key` (sensitive, multiline PEM content)

Use `private_key` in HCP instead of filesystem paths. This repo supports both:

- `private_key_path` for local CLI use
- `private_key` for remote HCP runs

Do not set both at once.

### 3) Permissions and policies

- Enable branch protection in GitHub for your default branch.
- In HCP workspace settings, disable auto-apply unless you explicitly want automatic production changes.
- Use HCP run tasks/policy checks (Sentinel/OPA) before apply for production.

### 4) GitHub Actions + HCP workflow (optional future extension)

- GitHub Actions handles static quality gates (`fmt`, `validate`, `tflint`).
- HCP Terraform can handle remote plan/apply and state locking.
- If needed later, add a separate manual GitHub workflow for HCP run queueing.

### 5) First verification run

1. Push a small commit.
2. Confirm GitHub Actions infra quality jobs pass.
3. Confirm HCP workspace receives a VCS-driven run (if connected).
4. Review the plan in HCP.
5. Apply in HCP UI (manual) once plan is expected.
