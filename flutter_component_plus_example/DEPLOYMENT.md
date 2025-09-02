# Deploying to GitHub Pages

This Flutter project is configured to automatically deploy to GitHub Pages using GitHub Actions.

## Automatic Deployment

The project includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that will:

1. **Trigger**: Automatically run on every push to `main` or `master` branch
2. **Build**: Compile the Flutter web app
3. **Deploy**: Push the built files to GitHub Pages

## Setup Steps

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it `Reusable-Flutter-Components-Package` (or your preferred name)
3. Make it public (required for GitHub Pages)

### 2. Push Your Code

```bash
# Initialize git if not already done
git init

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/flutter_component_plus_example.git

# Add all files
git add .

# Commit
git commit -m "Initial commit"

# Push to main branch
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. The workflow will automatically deploy your app

### 4. Access Your App

Your app will be available at:
```
https://YOUR_USERNAME.github.io/Reusable-Flutter-Components-Package/
```

## Manual Deployment (Alternative)

If you prefer manual deployment:

1. **Build the web app:**
   ```bash
   flutter build web --release --base-href /flutter_component_plus_example/
   ```

2. **Create a `docs` folder** in your repository root

3. **Copy build files:**
   ```bash
   cp -r build/web/* docs/
   ```

4. **Commit and push:**
   ```bash
   git add docs/
   git commit -m "Deploy to GitHub Pages"
   git push
   ```

5. **Configure Pages source** to `/docs` folder

## Troubleshooting

### Build Issues
- Ensure Flutter supports web: `flutter doctor`
- Check all dependencies support web platform
- Run `flutter clean` before building

### Deployment Issues
- Check GitHub Actions tab for build logs
- Ensure repository is public
- Verify GitHub Pages is enabled in repository settings

### App Not Loading
- Check the base href matches your repository name
- Verify all assets are properly referenced
- Check browser console for errors

## Customization

### Change Repository Name
If you use a different repository name, update:
1. `--base-href` in `.github/workflows/deploy.yml`
2. `destination_dir` in the workflow
3. Repository name in GitHub

### Custom Domain
To use a custom domain:
1. Add `CNAME` file in `web/` folder
2. Configure DNS settings
3. Update GitHub Pages settings

## Support

For issues with:
- **Flutter Web**: Check [Flutter Web Documentation](https://docs.flutter.dev/get-started/web)
- **GitHub Pages**: Check [GitHub Pages Documentation](https://docs.github.com/en/pages)
- **GitHub Actions**: Check [GitHub Actions Documentation](https://docs.github.com/en/actions)
