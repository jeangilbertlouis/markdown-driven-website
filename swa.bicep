// Bicep script to deploy a Static Web App on Azure
// Usage: az deployment group create --resource-group <rg-name> --template-file swa.bicep --parameters siteName=<site-name> location=<location>

param siteName string {
  minLength: 2
  maxLength: 60
  metadata: {
    description: 'The name of the Static Web App (must be unique globally)'
  }
}

param location string = resourceGroup().location

param sku string = 'Free' {
  allowedValues: [
    'Free'
    'Standard'
  ]
}

var swaName = toLower(siteName)

resource swa 'Microsoft.Web/staticSites@2022-09-01' = {
  name: swaName
  location: location
  sku: {
    tier: sku
    name: sku
  }
  properties: {
    provider: 'GitHub'
    repositoryUrl: 'https://github.com/jeangilbertlouis/markdown-driven-website'
    branch: 'main'
    buildProperties: {
      appLocation: '/'
      outputLocation: 'dist'
      appBuildCommand: 'npm run build'
    }
  }
}

resource githubLink 'Microsoft.Web/staticSites/userProvidedFunctionApps@2022-09-01' = {
  name: '${swaName}/userProvidedFunctionApps'
  properties: {
    functionAppResourceGroup: resourceGroup().id
  }
}

output swaName string = swa.name
output swaDefaultHostUrl string = swa.properties.defaultHostname
output swaRepositoryUrl string = swa.properties.repositoryUrl
