#!/bin/bash

# Flutter Component Plus Example - Deployment Script
# This script helps deploy the Flutter web app to GitHub Pages

echo "🚀 Starting deployment process..."

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for web
echo "🔨 Building for web..."
flutter build web --release --base-href /Reusable-Flutter-Components-Package/

if [ $? -eq 0 ]; then
    echo "✅ Web build successful!"
    echo ""
    echo "📁 Build files are in: build/web/"
    echo ""
    echo "🌐 To deploy to GitHub Pages:"
    echo "   1. Create a GitHub repository named 'Reusable-Flutter-Components-Package'"
    echo "   2. Push this code to the repository"
    echo "   3. Enable GitHub Pages in repository settings"
    echo "   4. The GitHub Actions workflow will auto-deploy on push"
    echo ""
    echo "🔗 Your app will be available at:"
    echo "   https://YOUR_USERNAME.github.io/Reusable-Flutter-Components-Package/"
    echo ""
    echo "📖 See DEPLOYMENT.md for detailed instructions"
else
    echo "❌ Web build failed!"
    exit 1
fi
