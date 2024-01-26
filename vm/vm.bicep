param vmConfiguration object
param nsgConfiguration object
param nicConfiguration object
param subnetConfiguration object
param vnetConfiguration object
param location string = resourceGroup().location

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicConfiguration.name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgConfiguration.name
  location: location
  properties: {
    securityRules: nsgConfiguration.securityRules
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetConfiguration.name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetConfiguration.addressPrefix
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: virtualNetwork
  name: subnetConfiguration.name
  properties: {
    addressPrefix: subnetConfiguration.addressPrefix
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmConfiguration.name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmConfiguration.sku
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: vmConfiguration.diskConfiguration.osDisk.type
        }
      }
      imageReference: vmConfiguration.image
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}
