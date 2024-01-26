using 'main.bicep'

var resourceGroupName = 'bicepparam-test-group'
var resourceGroupLocation = 'westus'

param resourceGroupConfiguration = {
  name: resourceGroupName
  location: resourceGroupLocation
}
