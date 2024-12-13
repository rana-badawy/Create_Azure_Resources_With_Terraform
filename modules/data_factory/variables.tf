variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "adf_name" {
  description = "Name of the Data Factory"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}