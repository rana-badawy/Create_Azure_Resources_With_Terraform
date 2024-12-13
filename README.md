# Create Azure Resources with Terraform

This repository contains Terraform configuration files to create and manage Azure resources. The resources included are:

- **Resource Group**
- **Storage Account**
- **Azure Data Factory**
- **Data Factory Pipeline**

## Prerequisites

To use this repository, ensure you have the following installed:

1. [Terraform](https://www.terraform.io/downloads)
2. [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
3. An active Azure subscription

## Setup and Usage

1. **Clone the Repository**
   ```bash
   git clone https://github.com/rana-badawy/Create_Azure_Resources_With_Terraform.git
   cd Create_Azure_Resources_With_Terraform
   ```

2. **Authenticate with Azure**
   Use the Azure CLI to log in to your Azure account:
   ```bash
   az login
   ```

4. **Initialize Terraform**
   Initialize Terraform to download necessary provider plugins:
   ```bash
   terraform init
   ```

5. **Review Variables**
   Open the `variables.tfvars` file and update the variable values as needed. If you don't provide this file, you will be asked to enter the values from the command line while running.

6. **Plan the Deployment**
   Generate an execution plan to review changes before applying them:
   ```bash
   terraform plan -var-file="variables.tfvars"
   ```

7. **Apply the Configuration**
   Apply the Terraform configuration to create the resources:
   ```bash
   terraform apply -var-file="variables.tfvars"
   ```
   Confirm the prompt by typing `yes`.

8. **Verify the Resources**
   Use the Azure Portal or Azure CLI to verify the creation of the resources.

## Files Overview

- **`main.tf`**: Contains the primary configuration for creating Azure resources.
- **`variables.tf`**: Defines input variables for customization.
- Module folder has the same structure for each resource separately.

## Cleanup

To remove all the resources created by this Terraform configuration, run:
```bash
terraform destroy -var-file="variables.tfvars"
```
Confirm the prompt by typing `yes`.
