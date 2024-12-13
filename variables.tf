variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "source_folder_name" {
  description = "Name of the source folder in the storage container"
  type        = string
}

variable "destination_folder_name" {
  description = "Name of the destination folder in the storage container"
  type        = string
}

variable "container_access_type" {
  description = "Access level for the storage container"
  type        = string
  default     = "private"
}

variable "adf_name" {
  description = "Name of the Data Factory"
  type        = string
}
