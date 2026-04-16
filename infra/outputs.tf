output "availability_domains" {
  description = "Availability domain names available to the stack"
  value       = var.availability_domain != null ? [var.availability_domain] : data.oci_identity_availability_domains.ads[0].availability_domains[*].name
}

output "selected_image_name" {
  description = "Resolved image display name"
  value       = local.selected_image_name
}

output "selected_image_id" {
  description = "Resolved image OCID"
  value       = local.selected_image_id
}

output "available_images_map" {
  description = "Map of available image display names to OCIDs"
  value       = local.available_images_map
}

output "available_image_names" {
  description = "List of available image names"
  value       = keys(local.available_images_map)
}

output "available_image_ids" {
  description = "List of available image OCIDs"
  value       = values(local.available_images_map)
}

output "ampere_a1_private_ips" {
  description = "Private IP addresses for created instances"
  value       = oci_core_instance.ampere_a1[*].private_ip
}

output "ampere_a1_public_ips" {
  description = "Public IP addresses for created instances"
  value       = oci_core_instance.ampere_a1[*].public_ip
}

output "ampere_a1_boot_volume_ids" {
  description = "Boot volume OCIDs for created instances"
  value       = oci_core_instance.ampere_a1[*].boot_volume_id
}
