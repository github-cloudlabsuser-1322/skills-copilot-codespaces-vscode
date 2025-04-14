# Login to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "MyResourceGroup" # Replace with your resource group name
$location = "EastUS"                  # Replace with your desired location
$vmName = "MyVM"
$vmSize = "Standard_DS1_v2"
$adminUsername = "azureuser"
$adminPassword = "P@ssw0rd123!"       # Use a secure password
$networkName = "MyVNet"
$subnetName = "MySubnet"
$publicIpName = "MyPublicIP"
$nicName = "MyNIC"
$image = "Win2019Datacenter"         # Change to your desired image

# Create a Virtual Network
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location `
  -Name $networkName -AddressPrefix "10.0.0.0/16"

# Create a Subnet
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Create a Public IP Address
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location `
  -Name $publicIpName -AllocationMethod Dynamic

# Create a Network Interface
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location `
  -Name $nicName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id

# Create the Virtual Machine Configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize | `
  Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential (New-Object PSCredential ($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))) | `
  Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus $image -Version "latest" | `
  Add-AzVMNetworkInterface -Id $nic.Id

# Create the Virtual Machine
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig