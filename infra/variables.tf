variable "compartment_ocid" {
  description = "Compartment OCID where resources are provisioned"
  type        = string
}

variable "tenancy_ocid" {
  description = "Optional OCI Tenancy OCID override for provider auth"
  type        = string
  default     = null
}

variable "user_ocid" {
  description = "Optional OCI User OCID override for provider auth"
  type        = string
  default     = null
}

variable "fingerprint" {
  description = "Optional fingerprint override for OCI API key auth"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Optional path override for OCI API private key (best for local CLI usage)"
  type        = string
  default     = null
}

variable "private_key" {
  description = "Optional OCI API private key content (best for HCP Terraform sensitive variable)"
  type        = string
  default     = null
  sensitive   = true
}

variable "region" {
  description = "Optional OCI region override (for example: us-ashburn-1)"
  type        = string
  default     = null
}

variable "availability_domain" {
  description = "Optional explicit availability domain name; skips AD lookup when set"
  type        = string
  default     = null
}

variable "oci_vcn_cidr_block" {
  description = "CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "oci_vcn_cidr_subnet" {
  description = "CIDR subnet inside the VCN"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ampere_a1_shape" {
  description = "OCI shape for Ampere instances"
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "name_prefix" {
  description = "Unified name prefix applied to network and compute resources"
  type        = string
  default     = "ampere"

  validation {
    condition     = length(var.name_prefix) > 1 && can(regex("^[a-z0-9-]+$", lower(var.name_prefix)))
    error_message = "name_prefix must be at least 2 characters and contain only letters, numbers, and hyphens."
  }
}

variable "oci_vm_count" {
  description = "Number of Ampere A1 instances to create"
  type        = number
  default     = 1

  validation {
    condition     = var.oci_vm_count >= 1 && var.oci_vm_count <= 4
    error_message = "oci_vm_count must be between 1 and 4."
  }
}

variable "ampere_a1_vm_memory" {
  description = "RAM in GB for each Ampere A1 instance"
  type        = number
  default     = 6
}

variable "ampere_a1_cpu_core_count" {
  description = "OCPU count for each Ampere A1 instance"
  type        = number
  default     = 1
}

variable "assign_public_ip" {
  description = "Assign a public IP to each instance VNIC"
  type        = bool
  default     = true
}

variable "cloud_init_template_file" {
  description = "Optional path to a cloud-init file"
  type        = string
  default     = null
}

variable "ssh_public_key" {
  description = "Public SSH key injected into instance metadata for login"
  type        = string

  validation {
    condition     = can(regex("^ssh-(rsa|ed25519|ecdsa)", var.ssh_public_key))
    error_message = "ssh_public_key must be a valid OpenSSH public key string."
  }
}

variable "ubuntu_version" {
  description = "Ubuntu version used in OCI image search"
  type        = string
  default     = "24.04"
}
