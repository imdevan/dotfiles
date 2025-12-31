#!/bin/bash

# Script to prepare a Lovable project for GitHub Pages deployment
# Usage: Call this script from the root of your Lovable project
# usage: ~/dotfiles/functions/scripts/lovely.sh [--favicon <url>] [--og-image <url>]
# alias: lov
# Flags:
#   --favicon <url>    Add a favicon link to index.html (supports relative paths like "/favicon.ico" or absolute URLs like "https://example.com/icon.png")
#   --og-image <url>   Add og:image and twitter:image meta tags to index.html (supports relative paths or absolute URLs)

set -e

# Define colors for formatting
blue='\033[0;34m'
green='\033[0;32m'
yellow='\033[1;33m'
teal='\033[0;36m'
bold='\033[1m'
reset='\033[0m'

# Helper function to check if a flag exists
has_flag() {
  local flag="$1"
  shift
  for arg in "$@"; do
    if [ "$arg" = "$flag" ]; then
      return 0
    fi
  done
  return 1
}

# Helper function to get flag value
get_flag_value() {
  local flag="$1"
  shift
  local args=("$@")
  
  for i in "${!args[@]}"; do
    if [ "${args[$i]}" = "$flag" ] && [ $((i + 1)) -lt ${#args[@]} ]; then
      echo "${args[$((i + 1))]}"
      return 0
    fi
  done
  return 1
}

# Parse flags
FAVICON_URL=""
OG_IMAGE_URL=""

if has_flag "--favicon" "$@"; then
  FAVICON_URL=$(get_flag_value "--favicon" "$@")
fi

if has_flag "--og-image" "$@"; then
  OG_IMAGE_URL=$(get_flag_value "--og-image" "$@")
fi

# Get the project name from the current directory
PROJECT_NAME=$(basename "$(pwd)")

echo -e "${blue}Preparing project '${bold}${PROJECT_NAME}${reset}${blue}' for GitHub Pages...${reset}"

# Create .github/workflows directory if it doesn't exist
mkdir -p .github/workflows

# Create/override the deploy workflow file
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

echo -e "${green}✓ Created/updated .github/workflows/deploy.yml${reset}"

# Check if vite.config.ts exists
if [ ! -f "vite.config.ts" ]; then
  echo -e "${yellow}Warning: vite.config.ts not found. Creating a new one...${reset}"
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
    echo -e "${green}✓ Created vite.config.ts${reset}"
else
  # Modify existing vite.config.ts
  # Check if the base configuration already exists with the correct project name
  if grep -q "base: mode === \"production\" ? \"/${PROJECT_NAME}/\"" vite.config.ts; then
    echo -e "${blue}ℹ Base path in vite.config.ts already set to '/${PROJECT_NAME}/'${reset}"
  elif grep -q 'base:.*production' vite.config.ts; then
    # Replace existing base configuration - replace any project name in the base line
    # Pattern matches: base: mode === "production" ? "/ANYTHING/" : "/"
    # Use perl for more reliable pattern matching across platforms
    perl -i -pe "s|(base: mode === \"production\" ? \"/)[^\"]*(\" : \"/\")|\1${PROJECT_NAME}\2|" vite.config.ts
    echo -e "${green}✓ Updated base path in vite.config.ts to '/${PROJECT_NAME}/'${reset}"
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
      echo -e "${green}✓ Added base path configuration to vite.config.ts${reset}"
    else
      echo -e "${yellow}Warning: vite.config.ts doesn't match expected format. Please check manually.${reset}"
      echo -e "${yellow}Please manually add this line inside the defineConfig object:${reset}"
      echo -e "${yellow}  base: mode === \"production\" ? \"/${PROJECT_NAME}/\" : \"/\",${reset}"
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

echo -e "${green}✓ Created/updated README.md${reset}"

# Modify src/App.tsx to add basename to BrowserRouter
if [ -f "src/App.tsx" ]; then
  # Check if BrowserRouter exists
  if grep -q "<BrowserRouter" src/App.tsx; then
    # Check if basename already exists with the correct project name
    if grep -q "basename=\{import\.meta\.env\.PROD \? \"/${PROJECT_NAME}\"" src/App.tsx; then
      echo -e "${blue}ℹ Basename in src/App.tsx already set to '/${PROJECT_NAME}'${reset}"
    elif grep -q "basename=" src/App.tsx; then
      # Update existing basename - replace the project name in the basename
      perl -i -pe "s|(basename=\{import\.meta\.env\.PROD \? \"/)[^\"]*(\" : \"\"\})|\1${PROJECT_NAME}\2|g" src/App.tsx
      echo -e "${green}✓ Updated basename in src/App.tsx${reset}"
    else
      # Add basename to BrowserRouter - match <BrowserRouter> or <BrowserRouter ...>
      perl -i -pe "s|<BrowserRouter([^>]*)>|<BrowserRouter\1 basename={import.meta.env.PROD ? \"/${PROJECT_NAME}\" : \"\"}>|g" src/App.tsx
      echo -e "${green}✓ Added basename to BrowserRouter in src/App.tsx${reset}"
    fi
  else
    echo -e "${yellow}Warning: BrowserRouter not found in src/App.tsx${reset}"
  fi
else
  echo -e "${yellow}Warning: src/App.tsx not found${reset}"
fi

# Handle og:image, twitter:image meta tags, and favicon links in index.html
if [ -f "index.html" ]; then
  # Check if tags already exist with correct values (for idempotency)
  NEEDS_OG_UPDATE=true
  NEEDS_FAVICON_UPDATE=true
  OG_REMOVED=false
  FAVICON_REMOVED=false
  
  if [ -n "$OG_IMAGE_URL" ]; then
    # Check if both og:image and twitter:image exist with correct values
    if grep -q "property=\"og:image\".*content=\"${OG_IMAGE_URL}\"" index.html 2>/dev/null && \
       grep -q "name=\"twitter:image\".*content=\"${OG_IMAGE_URL}\"" index.html 2>/dev/null; then
      NEEDS_OG_UPDATE=false
    fi
  fi
  
  if [ -n "$FAVICON_URL" ]; then
    # Check if favicon exists with correct value
    if grep -q "rel=\"icon\".*href=\"${FAVICON_URL}\"" index.html 2>/dev/null; then
      NEEDS_FAVICON_UPDATE=false
    fi
  fi
  
  # Remove existing tags that need updating (in one pass)
  if [ "$NEEDS_OG_UPDATE" = true ]; then
    if grep -q "property=\"og:image\"" index.html 2>/dev/null || grep -q "name=\"twitter:image\"" index.html 2>/dev/null; then
      perl -i -pe 's/<meta\s+[^>]*property=["\047]og:image["\047][^>]*>//gi' index.html
      perl -i -pe 's/<meta\s+[^>]*name=["\047]twitter:image["\047][^>]*>//gi' index.html
      OG_REMOVED=true
    fi
  fi
  
  if [ "$NEEDS_FAVICON_UPDATE" = true ]; then
    if grep -q "rel=\"icon\"" index.html 2>/dev/null || grep -q "rel=\"shortcut icon\"" index.html 2>/dev/null; then
      perl -i -pe 's/<link\s+[^>]*rel=["\047](?:icon|shortcut\s+icon|apple-touch-icon)["\047][^>]*>//gi' index.html
      FAVICON_REMOVED=true
    fi
  fi
  
  # Insert all new tags in a single pass if any are needed
  if ([ "$NEEDS_OG_UPDATE" = true ] && [ -n "$OG_IMAGE_URL" ]) || ([ "$NEEDS_FAVICON_UPDATE" = true ] && [ -n "$FAVICON_URL" ]); then
    TEMP_FILE=$(mktemp)
    INSERTED=0
   c 
    while IFS= read -r line || [ -n "$line" ]; do
      if [[ "$line" =~ "</head>" ]] && [ "$INSERTED" -eq 0 ]; then
        # Insert og:image and twitter:image if needed
        if [ "$NEEDS_OG_UPDATE" = true ] && [ -n "$OG_IMAGE_URL" ]; then
          echo "  <meta property=\"og:image\" content=\"${OG_IMAGE_URL}\" />" >> "$TEMP_FILE"
          echo "  <meta name=\"twitter:image\" content=\"${OG_IMAGE_URL}\" />" >> "$TEMP_FILE"
        fi
        # Insert favicon if needed
        if [ "$NEEDS_FAVICON_UPDATE" = true ] && [ -n "$FAVICON_URL" ]; then
          echo -e "\t<link rel=\"icon\" href=\"${FAVICON_URL}\" />" >> "$TEMP_FILE"
        fi
        INSERTED=1
      fi
      echo "$line" >> "$TEMP_FILE"
    done < index.html
    
    mv "$TEMP_FILE" index.html
    
    # Report what was done
    if [ "$NEEDS_OG_UPDATE" = true ] && [ -n "$OG_IMAGE_URL" ]; then
      echo -e "${green}✓ Updated og:image and twitter:image meta tags in index.html${reset}"
    fi
    if [ "$NEEDS_FAVICON_UPDATE" = true ] && [ -n "$FAVICON_URL" ]; then
      echo -e "${green}✓ Updated favicon link in index.html${reset}"
    fi
  else
    # Report removals or that everything is already correct
    if [ "$OG_REMOVED" = true ]; then
      echo -e "${green}✓ Removed og:image and twitter:image meta tags from index.html${reset}"
    elif [ -n "$OG_IMAGE_URL" ]; then
      echo -e "${blue}ℹ og:image and twitter:image meta tags already set correctly${reset}"
    fi
    
    if [ "$FAVICON_REMOVED" = true ]; then
      echo -e "${green}✓ Removed favicon links from index.html${reset}"
    elif [ -n "$FAVICON_URL" ]; then
      echo -e "${blue}ℹ Favicon link already set correctly${reset}"
    fi
  fi
else
  echo -e "${yellow}Warning: index.html not found${reset}"
fi

# Delete favicon.ico file from public directory (only if no favicon URL is provided)
if [ -z "$FAVICON_URL" ]; then
  if [ -f "public/favicon.ico" ]; then
    rm "public/favicon.ico"
    echo -e "${green}✓ Deleted public/favicon.ico${reset}"
  elif [ -f "favicon.ico" ]; then
    # Also check root directory in case favicon is there
    rm "favicon.ico"
    echo -e "${green}✓ Deleted favicon.ico${reset}"
  fi
fi

echo ""
echo -e "${green}${bold}✓ Setup complete!${reset}"
echo -e "${blue}  Project name: ${bold}${PROJECT_NAME}${reset}"
echo -e "${blue}  GitHub Pages base path: ${bold}/${PROJECT_NAME}/${reset}"
echo ""
echo -e "${teal}Next steps:${reset}"
echo -e "${teal}  1. Commit and push the changes to GitHub${reset}"
echo -e "${teal}  2. Enable GitHub Pages in your repository settings${reset}"
echo -e "${teal}  3. Select 'GitHub Actions' as the source${reset}"
