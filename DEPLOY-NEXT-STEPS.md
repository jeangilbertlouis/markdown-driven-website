# Azure Static Web App Deployment - Next Steps

Your Static Web App `mdwebsite2026` has been deployed to:
- **URL**: https://polite-ocean-068477203.6.azurestaticapps.net
- **Resource Group**: `markdown-driven-website-rg`
- **Location**: West Europe

## Current Status

The SWA is configured but the build hasn't started yet because:

⚠️ **The repository is private** - Azure Static Web Apps cannot access private repositories without a GitHub Personal Access Token (PAT).

## Fix Options

### Option 1: Make Repository Public (Recommended for testing)

```bash
gh repo set-visibility jeangilbertlouis/markdown-driven-website --public
```

After making it public, trigger a build by making a small commit and pushing:

```bash
echo "# Build trigger" >> README.md
git commit -am "trigger build" && git push
```

### Option 2: Configure GitHub PAT for Private Repository

1. Create a GitHub Personal Access Token with `repo` scope:
   ```bash
   # Go to https://github.com/settings/tokens/new
   # Select: repo (all checkboxes)
   # Generate token
   ```

2. Update the SWA with the token:
   ```bash
   az staticwebapp update \
     --name mdwebsite2026 \
     --resource-group markdown-driven-website-rg \
     --repository-token <your-pat>
   ```

3. Trigger a build:
   ```bash
   az staticwebapp refresh-git-sync \
     --name mdwebsite2026 \
     --resource-group markdown-driven-website-rg
   ```

### Option 3: Use GitHub Actions Directly

Since Azure creates a GitHub Action workflow automatically, you can also trigger a manual build in GitHub:
1. Go to https://github.com/jeangilbertlouis/markdown-driven-website/actions
2. Click "Build and deploy" workflow
3. Run the workflow manually

## Verification

After the build completes, your site should be available at:
https://polite-ocean-068477203.6.azurestaticapps.net

You should see:
- Home page at `/`
- Blog at `/blog/`
- Tag pages at `/blog/tag/<tag>/`
- About page at `/about/`

## Monitoring

Check build status:
```bash
az staticwebapp show --name mdwebsite2026 --resource-group markdown-driven-website-rg
```

View logs:
```bash
az staticwebapp log deployment show --name mdwebsite2026 --resource-group markdown-driven-website-rg
```

## Custom Domain (Optional)

To add a custom domain:

```bash
az staticwebapp hostname add \
  --name mdwebsite2026 \
  --resource-group markdown-driven-website-rg \
  --hostname <your-domain.com>
```

Then configure DNS CNAME pointing to `polite-ocean-068477203.6.azurestaticapps.net`.

## Cleanup

To delete the resource group and all resources:

```bash
az group delete --name markdown-driven-website-rg
```
