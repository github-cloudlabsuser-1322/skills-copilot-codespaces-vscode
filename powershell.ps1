# Login to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "example-resources"
$location = "eastus"
$storageAccountName = "examplestorageacct"
$skuName = "Standard_LRS"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                     -Name $storageAccountName `
                     -Location $location `
                     -SkuName $skuName `
                     -Kind StorageV2 `
                     -Tags @{ environment = "staging" }