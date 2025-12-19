#!/bin/bash

# Function: jobbies
# Description: Open google chrome to job search bookmarks with dynamic configuration
# Usage: jobbies [keyword1] [keyword2] ... or jobbies --config to show configuration
# Alias: j

function jobbies() {
  # Configuration - site names and URLs
  local site_names=("linkedin" "indeed" "glassdoor")
  local linkedin_url="https://www.linkedin.com/jobs/search/?distance=25&f_TPR=r86400&f_WT=1%2C3&geoId=104116203&origin=JOB_SEARCH_PAGE_JOB_FILTER&sortBy=DD&keywords="
  local indeed_url="https://www.indeed.com/jobs?l=Seattle%2C+WA&ts=1763062084156&from=searchOnHP&rq=1&rsIdx=0&newcount=326&fromage=last&vjk=1fc220b650473a10&q="
  local glassdoor_url="https://www.glassdoor.com/Job/seattle-wa-{keyword}-jobs-SRCH_IL.0,10_IC1150505_KO11,21.htm?fromAge=3"

  # Default keywords if none provided
  local default_keywords=("fullstack" "frontend" "typescript" "react")

  # Parse arguments
  local keywords=()
  local show_config=false
  local dry_run=false

  if [[ $# -eq 0 ]]; then
    keywords=("${default_keywords[@]}")
  else
    for arg in "$@"; do
      case "$arg" in
      --config | --show-config | -c)
        show_config=true
        ;;
      --dry-run | --test | -t)
        dry_run=true
        ;;
      --help | -h)
        echo "Usage: jobbies [keyword1] [keyword2] ... [options]"
        echo "Options:"
        echo "  --config, -c     Show current configuration"
        echo "  --dry-run, -t    Show URLs without opening them"
        echo "  --help, -h       Show this help"
        echo "Examples:"
        echo "  jobbies                    # Use default keywords"
        echo "  jobbies python django      # Search for python and django jobs"
        echo "  jobbies --config           # Show current configuration"
        echo "  jobbies python --dry-run   # Show URLs for python without opening"
        return 0
        ;;
      *)
        keywords+=("$arg")
        ;;
      esac
    done
  fi

  # Show configuration if requested
  if [[ "$show_config" == true ]]; then
    echo "Job Sites Configuration:"
    echo "  linkedin: $linkedin_url"
    echo "  indeed: $indeed_url"
    echo "  glassdoor: $glassdoor_url"
    echo ""
    echo "Default Keywords: ${default_keywords[*]}"
    return 0
  fi

  # Build URLs dynamically - grouped by job site
  local urls=()

  # LinkedIn URLs - all keywords for LinkedIn first
  for keyword in "${keywords[@]}"; do
    urls+=("${linkedin_url}${keyword}")
  done

  # Indeed URLs - all keywords for Indeed second
  for keyword in "${keywords[@]}"; do
    urls+=("${indeed_url}${keyword}")
  done

  # Glassdoor URLs - all keywords for Glassdoor third
  for keyword in "${keywords[@]}"; do
    local glassdoor_final="${glassdoor_url/\{keyword\}/$keyword}"
    urls+=("$glassdoor_final")
  done

  # Display what we're opening
  echo "Opening ${#urls[@]} job search tabs for keywords: ${keywords[*]}"
  echo "Sites: ${site_names[*]}"

  # Show URLs if dry run, otherwise open them
  if [[ "$dry_run" == true ]]; then
    echo ""
    echo "URLs that would be opened:"
    for url in "${urls[@]}"; do
      echo "  $url"
    done
  else
    # Open all URLs in one new Chrome window as separate tabs
    open -na "Google Chrome" --args --new-window "${urls[@]}"
  fi
}

# Create alias
alias j="jobbies"
