#!/bin/sh

# Function: jobbies
# Description: Open google chrome to job search bookmarks
# Usage: jobbies [arguments]
# Alias: j

function jobbies() {
    # local
    # # Open Chrome with specific URLs in a new window
    # /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    #     --new-window \
    #     "https://example1.com" \
    #     "https://example2.com" \
    #     "https://example3.com"
    #
    # keywords=fullstack
    #   https://www.indeed.com/jobs?q=typescript&l=Seattle%2C+WA&sc=0kf%3Aocc%28ZW3TH%29%3B&radius=50&rbl=Seattle%2C+WA&sort=date&fromage=3&jlid=1e8a7dce52945215&vjk=26a00caa9ab927b8
    local full="fullstack"   
    local front="frontend"
    local typescript="typescript"
    local linkedin="https://www.linkedin.com/jobs/search/"
    local linkedin_query="?distance=25&f_TPR=r86400&f_WT=1%2C3&geoId=104116203&origin=JOB_SEARCH_PAGE_JOB_FILTER&sortBy=DD&keywords="
    local indeed="https://www.indeed.com/jobs"    
    local indeed_query="l=Seattle%2C+WA&sc=0kf%3Aocc%28ZW3TH%29%3B&radius=50&rbl=Seattle%2C+WA&sort=date&fromage=3&jlid=1e8a7dce52945215&vjk=26a00caa9ab927b8&q="

    # Define array of URLs
    # local urls=( 'https://github.com')
    local urls=(
        "$linkedin$linkedin_query$full"
        "$linkedin$linkedin_query$front"
        "$linkedin$linkedin_query$typescript"
        "$indeed$indeed_query$full"
        # "https://news.ycombinator.com"
        # "https://github.com"
    )

    
    # Open all URLs in one new Chrome window as separate tabs
    open -na "Google Chrome" --args --new-window "${urls[@]}"

    # Open each URL in a new Chrome window
    # for url in "${urls[@]}"; do
    #     open -na "Google Chrome" --args --new-window "$url"
    # done

}

# Create alias
alias j="jobbies"
