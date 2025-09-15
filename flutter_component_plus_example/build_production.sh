#!/bin/bash

# Production Build Script for Flutter Web
# This script optimizes the build to prevent white screen issues

echo "🚀 Building Flutter Web for Production..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build with production optimizations
echo "🔨 Building with production optimizations..."
flutter build web \
  --release \
  --tree-shake-icons \
  --base-href /Reusable-Flutter-Components-Package/ \
  --optimization-level 4 \
  --no-source-maps

if [ $? -eq 0 ]; then
    echo "✅ Production build successful!"
    echo ""
    echo "📁 Build files are in: build/web/"
    echo ""
    echo "🔧 Production optimizations applied:"
    echo "   ✓ Maximum optimization level (4) for best performance"
    echo "   ✓ Tree-shaken icons for smaller bundle size"
    echo "   ✓ No source maps for smaller bundle size"
    echo "   ✓ Optimized base href for deployment"
    echo ""
    echo "🌐 Ready to deploy to:"
    echo "   - Netlify: Drag & drop build/web folder"
    echo "   - Vercel: Connect repository with vercel.json"
    echo "   - Firebase: Use firebase.json configuration"
    echo ""
    echo "📖 See NETLIFY_DEPLOYMENT.md for deployment instructions"
else
    echo "❌ Production build failed!"
    exit 1
fi
