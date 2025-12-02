#!/bin/bash

# Script to prepare a Lovable project for GitHub Pages deployment
# Usage: Call this script from the root of your Lovable project
# usage: ~/dotfiles/functions/scripts/lovely.sh
# alias: lov

set -e

# Source colors for formatting
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../shared/colors.sh"

# Get the project name from the current directory
PROJECT_NAME=$(basename "$(pwd)")

echo "${blue}Preparing project '${bold}${PROJECT_NAME}${reset}${blue}' for GitHub Pages...${reset}"

# Create .github/workflows directory if it doesn't exist
mkdir -p .github/workflows

# Create the deploy workflow file
cat >.github/workflows/deploy.yml <<'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build
        env:
          NODE_ENV: production

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF

echo "${green}✓ Created .github/workflows/deploy.yml${reset}"

# Check if vite.config.ts exists
if [ ! -f "vite.config.ts" ]; then
  echo "${yellow}Warning: vite.config.ts not found. Creating a new one...${reset}"
  cat >vite.config.ts <<EOF
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import { componentTagger } from "lovable-tagger";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  base: mode === "production" ? "/${PROJECT_NAME}/" : "/",
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react(), mode === "development" && componentTagger()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
}));
EOF
  echo "${green}✓ Created vite.config.ts${reset}"
else
  # Modify existing vite.config.ts
  # Check if the base configuration already exists
  if grep -q 'base:.*production' vite.config.ts; then
    # Replace existing base configuration - replace any project name in the base line
    # Pattern matches: base: mode === "production" ? "/ANYTHING/" : "/"
    # Use perl for more reliable pattern matching across platforms
    perl -i -pe "s|(base: mode === \"production\" ? \"/)[^\"]*(\" : \"/\")|\1${PROJECT_NAME}\2|" vite.config.ts
    echo "${green}✓ Updated base path in vite.config.ts to '/${PROJECT_NAME}/'${reset}"
  else
    # Check if there's a defineConfig call - if so, add the base config
    if grep -q "defineConfig" vite.config.ts; then
      # Use a more reliable approach: create a temp file and process it
      TEMP_FILE=$(mktemp)
      FOUND_OPENING=0

      while IFS= read -r line || [ -n "$line" ]; do
        # Check if this is the opening brace line after defineConfig
        if [[ "$line" =~ "=> ({" ]] && [[ "$FOUND_OPENING" -eq 0 ]]; then
          echo "$line"
          echo "  base: mode === \"production\" ? \"/${PROJECT_NAME}/\" : \"/\","
          FOUND_OPENING=1
        else
          echo "$line"
        fi
      done <vite.config.ts >"$TEMP_FILE"

      mv "$TEMP_FILE" vite.config.ts
      echo "${green}✓ Added base path configuration to vite.config.ts${reset}"
    else
      echo "${yellow}Warning: vite.config.ts doesn't match expected format. Please check manually.${reset}"
      echo "${yellow}Please manually add this line inside the defineConfig object:${reset}"
      echo "${yellow}  base: mode === \"production\" ? \"/${PROJECT_NAME}/\" : \"/\",${reset}"
    fi
  fi
fi

# Create/override README.md
cat >README.md <<EOF
# ${PROJECT_NAME}



Seeded with [lovable](https://lovable.dev/); 

Crafted by [me](https://devan.gg)

Run with bun 🐰

\`\`\`

bun i && bun dev

\`\`\`
EOF

echo "${green}✓ Created/updated README.md${reset}"

# Modify src/App.tsx to add basename to BrowserRouter
if [ -f "src/App.tsx" ]; then
  # Check if BrowserRouter exists
  if grep -q "<BrowserRouter" src/App.tsx; then
    # Check if basename already exists
    if grep -q "basename=" src/App.tsx; then
      # Update existing basename - replace the project name in the basename
      perl -i -pe "s|(basename=\{import\.meta\.env\.PROD \? \"/)[^\"]*(\" : \"\"\})|\1${PROJECT_NAME}\2|g" src/App.tsx
      echo "${green}✓ Updated basename in src/App.tsx${reset}"
    else
      # Add basename to BrowserRouter - match <BrowserRouter> or <BrowserRouter ...>
      perl -i -pe "s|<BrowserRouter([^>]*)>|<BrowserRouter\1 basename={import.meta.env.PROD ? \"/${PROJECT_NAME}\" : \"\"}>|g" src/App.tsx
      echo "${green}✓ Added basename to BrowserRouter in src/App.tsx${reset}"
    fi
  else
    echo "${yellow}Warning: BrowserRouter not found in src/App.tsx${reset}"
  fi
else
  echo "${yellow}Warning: src/App.tsx not found${reset}"
fi

echo ""
echo "${green}${bold}✓ Setup complete!${reset}"
echo "${blue}  Project name: ${bold}${PROJECT_NAME}${reset}"
echo "${blue}  GitHub Pages base path: ${bold}/${PROJECT_NAME}/${reset}"
echo ""
echo "${teal}Next steps:${reset}"
echo "${teal}  1. Commit and push the changes to GitHub${reset}"
echo "${teal}  2. Enable GitHub Pages in your repository settings${reset}"
echo "${teal}  3. Select 'GitHub Actions' as the source${reset}"
