resource "azurerm_data_factory" "adf" {
  location            = var.location
  name                = var.adf_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_folder" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "blob_ls" {
  data_factory_id   = azurerm_data_factory.adf.id
  name              = "storage_ls"
  connection_string = data.azurerm_storage_account.storage_folder.primary_connection_string
}

resource "azurerm_data_factory_dataset_binary" "source_dataset" {
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.blob_ls.name
  name                = "source_dataset"
  sftp_server_location {
    filename = "test.txt"
    path     = "source"
  }
}

resource "azurerm_data_factory_dataset_binary" "destination_dataset" {
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.blob_ls.name
  name                = "destination_dataset"
  sftp_server_location {
    filename = "test-${formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())}.txt"
    path     = "destination"
  }
}

resource "azurerm_data_factory_pipeline" "copy_pipeline" {
  data_factory_id = azurerm_data_factory.adf.id
  name            = "Copy Pipeline"
  activities_json = <<JSON
    [
      {
        "name": "Copy From Storage",
        "type": "Copy",
        "inputs": [
          {
            "referenceName": "source_dataset",
            "type": "DatasetReference"
          }
        ],
        "outputs": [
          {
            "referenceName": "destination_dataset",
            "type": "DatasetReference"
          }
        ],
        "typeProperties": {
          "source": {
            "type": "BinarySource",
            "recursive": true
          },
          "sink": {
            "type": "BinarySink"
          },
          "enableStaging": false
        },
        "policy": {
          "timeout": "7.00:00:00",
          "retry": 0,
          "retryIntervalInSeconds": 30,
          "secureInput": false,
          "secureOutput": false
        },
        "scheduler": {
          "frequency": "Day",
          "interval": 1
        },
        "external": true
      }
    ]
  JSON

  depends_on = [
    azurerm_data_factory_dataset_binary.source_dataset,
    azurerm_data_factory_dataset_binary.destination_dataset
  ]
}