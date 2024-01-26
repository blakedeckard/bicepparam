using 'vm.bicep'

var vmName = 'linux-test-vm'
var vmSize = 'Standard_B1ls2'

param subnetConfiguration = {
  name: 'test-subnet'
  addressPrefix: '10.1.0.0/24'
}

param vnetConfiguration = {
  name: 'test-vnet'
  addressPrefix: '10.1.0.0/16'
}

param nsgConfiguration = {
  name: 'vm-nsg'
  securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
}

param nicConfiguration = {
  name: '${vmName}-nic'
}


param vmConfiguration = {
  name: vmName
  sku: vmSize
  osVersion: 'Ubuntu-2204'
  image: {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
  diskConfiguration: {
    osDisk: {
      type: 'Standard_LRS'
      size: '100'
    }
  }
}
