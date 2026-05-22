#!/bin/bash

# Kanban Board - Web Server Runner
# This script builds and runs the Kanban Board application on the web

set -e

echo "🚀 Building Kanban Board for Web..."
flutter build web --release

echo ""
echo "✅ Build complete!"
echo ""
echo "📱 Starting web server on http://localhost:8000"
echo ""

cd build/web
python3 -m http.server 8000

