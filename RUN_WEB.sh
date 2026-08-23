#!/bin/bash

# Kanban Board - Web Server Runner
# This script builds and runs the Kanban Board application on the web

set -e

APP_DIR="$(cd "$(dirname "$0")/apps/kanban_app" && pwd)"
cd "$APP_DIR"

echo "🚀 Building Kanban Board for Web..."
flutter build web --release

echo ""
echo "✅ Build complete!"
echo ""
echo "📱 Starting web server on http://localhost:8000"
echo ""

cd "$APP_DIR/build/web"
python3 -m http.server 8000
