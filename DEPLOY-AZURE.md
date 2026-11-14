# Deploy to Azure Static Web App

This directory contains Bicep and ARM template files to deploy the site to Azure Static Web Apps.

## Prerequisites

- Azure subscription
- Azure CLI installed (`az`)
- GitHub repository (this repo)

## Deployment Options

### Option 1: Using Bicep (Recommended)

```bash
# Login to Azure
az login

# Set your subscription (optional, if you have multiple)
az account set --subscription "<subscription-id-or-name>"

# Create resource group
az group create --name markdown-driven-website-rg --location westus

# Deploy using Bicep
az deployment group create \
  --resource-group markdown-driven-website-rg \
  --template-file swa.bicep \
  --parameters siteName=mdwebsite$(date +%s)
```

### Option 2: Using ARM Template

```bash
# Deploy using ARM template
az deployment group create \
  --resource-group markdown-driven-website-rg \
  --template-file swa.template.json \
  --parameters siteName=mdwebsite$(date +%s)
```

### Option 3: Deploy via Azure Portal

1. Click "Deploy to Azure" button
2. Fill in the parameters:
   - **Site Name**: Unique name for your Static Web App (e.g., `mdwebsite`)
   - **Location**: Azure region (e.g., `West US`)
   - **SKU**: `Free` or `Standard`
3. Review and create

## After Deployment

Once deployed, Azure will automatically:

1. Connect to your GitHub repository
2. Trigger a build on the `main` branch
3. Deploy the site to `https://<site-name>.azurestaticapps.net`

## GitHub Action (Optional)

The Static Web App will also create a GitHub Action workflow at `.github/workflows/azure-static-web-apps-*.yml` that keeps your site updated on future commits.

## Custom Domain (Optional)

To add a custom domain:

```bash
# Add custom domain
az web app hostname add \
  --resource-group markdown-driven-website-rg \
  --name <swa-name> \
  --hostname <your-domain.com>

# Configure DNS CNAME record pointing to <swa-name>.azurestaticapps.net
```

## Cleanup

```bash
# Delete resource group (and all resources)
az group delete --name markdown-driven-website-rg
```
