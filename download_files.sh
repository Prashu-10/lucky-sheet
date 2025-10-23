#!/usr/bin/env bash
set -e

echo "==> Setting up local static assets for Luckysheet + Streamlit..."

# Root folders
mkdir -p static/luckysheet/plugins/css
mkdir -p static/luckysheet/plugins/js
mkdir -p static/luckysheet/dist/css
mkdir -p static/luckysheet/dist
mkdir -p static/streamlit-component-lib

# ------------------ Luckysheet v2.1.13 ------------------
echo "-> Downloading Luckysheet v2.1.13 files..."

curl -L -o static/luckysheet/dist/luckysheet.umd.js \
  https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/luckysheet.umd.js

curl -L -o static/luckysheet/dist/plugins.css \
  https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/plugins.css

curl -L -o static/luckysheet/dist/css/luckysheet.css \
  https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/css/luckysheet.css

curl -L -o static/luckysheet/plugins/js/plugin.js \
  https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/plugins/js/plugin.js

curl -L -o static/luckysheet/plugins/css/plugins.css \
  https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/plugins/css/plugins.css

# ------------------ Streamlit Component Lib ------------------
echo "-> Downloading streamlit-component-lib..."

curl -L -o static/streamlit-component-lib/index.js \
  https://cdn.jsdelivr.net/npm/streamlit-component-lib@1/dist/index.js

# ------------------ Verification ------------------
echo
echo "==> Verifying file integrity..."
for f in \
  static/luckysheet/dist/luckysheet.umd.js \
  static/luckysheet/dist/plugins.css \
  static/luckysheet/dist/css/luckysheet.css \
  static/luckysheet/plugins/js/plugin.js \
  static/luckysheet/plugins/css/plugins.css \
  static/streamlit-component-lib/index.js
do
  if grep -q "<!DOCTYPE" "$f"; then
    echo "❌ Error: $f contains HTML (bad download)."
    echo "   Please re-run this script or check your network."
    exit 1
  else
    echo "✅ $f"
  fi
done

echo
echo "All files downloaded successfully!"
echo "Run your app with:"
echo "  streamlit run eval_app_v3.py --server.enableStaticServing true"

