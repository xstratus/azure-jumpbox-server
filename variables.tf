# ============================================================================
# This project is fully independent from the VNet project
# (azure-vnet-terraform). It does NOT read that project's state - instead,
# the network details it needs (resource group, location, subnet) are passed
# in explicitly as variables below.
#
# Get these values from the VNet project's outputs after a `terraform apply`
# there, e.g.:
#   terraform output -raw resource_group_name   (if you add that output)
#   terraform output -json app_subnet_ids
#
# Or look them up directly in the Azure Portal / via az cli:
#   az network vnet subnet list \
#     --resource-group rg-ha-vnet --vnet-name vnet-ha --output table
# ============================================================================

variable "resource_group_name" {
  description = "Name of the EXISTING resource group where the VNet lives (from the network project)"
  type        = string
  default     = "rg-ha-vnet"
}

variable "location" {
  description = "Azure region - must match the existing VNet's region"
  type        = string
  default     = "eastus"
}

variable "app_subnet_id" {
  description = "Full resource ID of the existing App subnet (AZ1) to deploy the management VM into. Get this from the network project's `app_subnet_ids` output, index 0."
  type        = string
}

variable "mgmt_vm_size" {
  description = "VM size for the isolated management VM"
  type        = string
  default     = "Standard_B1s"
}

variable "mgmt_admin_username" {
  description = "Admin username for the management VM"
  type        = string
  default     = "azureuser"
}

variable "mgmt_zone" {
  description = "Availability zone to deploy the management VM into (should match the AZ of app_subnet_id)"
  type        = string
  default     = "1"
}

variable "tags" {
  description = "Common tags applied to resources in this project"
  type        = map(string)
  default = {
    environment = "production"
    project     = "mgmt-jumpbox"
    managed_by  = "terraform"
  }
}
