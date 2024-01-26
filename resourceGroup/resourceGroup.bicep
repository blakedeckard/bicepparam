targetScope = 'subscription'

param resourceGroupConfiguration object

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupConfiguration.name
  location: resourceGroupConfiguration.location
}
