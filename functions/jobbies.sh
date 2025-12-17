#!/bin/sh

# Function: jobbies
# Description: Open google chrome to job search bookmarks
# Usage: jobbies [arguments]
# Alias: j

function jobbies() {
    # local
    # # Open Chrome with specific URLs in a new window

    # Keywords
    local full="fullstack"   
    local front="frontend"
    local typescript="typescript"

    # Domains
    local linkedin="https://www.linkedin.com/jobs/search/"
    local linkedin_query="?distance=25&f_TPR=r86400&f_WT=1%2C3&geoId=104116203&origin=JOB_SEARCH_PAGE_JOB_FILTER&sortBy=DD&keywords="

    local indeed="https://www.indeed.com/jobs"    
    local indeed_query="?l=Seattle%2C+WA&ts=1763062084156&from=searchOnHP&rq=1&rsIdx=0&newcount=326&fromage=last&vjk=1fc220b650473a10&q="
      
    local glassdoor="https://www.glassdoor.com/Job/"
    local glassdoor_query="seattle-wa-us-"
    local glassdoor_post_query="-jobs-SRCH_IL.0,13_IC1150505_KO14,22.htm?fromAge=3"

    # Define array of URLs
    local urls=(
        "$linkedin$linkedin_query$full"
        "$linkedin$linkedin_query$front"
        "$linkedin$linkedin_query$typescript"
        "$indeed$indeed_query$full"
        "$indeed$indeed_query$front"
        "$indeed$indeed_query$typescript"
        "$glassdoor$glassdoor_query$full$glassdoor_post_query"
        "$glassdoor$glassdoor_query$front$glassdoor_post_query" 
        "$glassdoor$glassdoor_query$typescript$glassdoor_post_query" 
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
