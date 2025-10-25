#!/bin/bash
# Codespaces post-create script
# This runs after the devcontainer is created

echo "🎉 Welcome to Snort Development Environment!"
echo ""
echo "📦 Installing dependencies..."
yarn install --immutable

echo ""
echo "✅ Setup complete!"
echo ""
echo "The development server will start automatically."
echo "Access your app at the forwarded port 3000"
echo ""
