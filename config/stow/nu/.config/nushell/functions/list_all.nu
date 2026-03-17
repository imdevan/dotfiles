# Function: list_all
# Description: List all files in directory with filtering and sorting
# Usage: list_all [flags] [query] [second_query]
# Flags:
#   -m: sort by modified time
#   -t: sort by type
#   -s: sort by size
#   -n: sort by name (default)
#   -r: reverse sort order
#   -h: show hidden files

export def list_all [
  ...args: string  # Query and flags
] {
  # Parse flags and arguments
  let flags = $args | where ($it | str starts-with '-')
  let non_flags = $args | where not ($it | str starts-with '-')
  
  # Determine sort column
  let sort = if ('-m' in $flags) {
    'modified'
  } else if ('-t' in $flags) {
    'type'
  } else if ('-s' in $flags) {
    'size'
  } else {
    'name'
  }
  
  # Check for reverse flag
  let reverse_flag = ('-r' in $flags)
  
  # Check for hidden flag
  let show_hidden = ('-h' in $flags)
  
  # Default reverse behavior based on sort type
  let default_rev = match $sort {
    'modified' => true,
    'size' => true,
    _ => false
  }
  
  # XOR logic: reverse if default_rev != reverse_flag
  let rev = ($default_rev != $reverse_flag)
  
  # Get query from non-flag arguments
  let query = if ($non_flags | length) > 0 {
    $non_flags | first
  } else {
    ''
  }
  
  # Get directory listing
  let rows = if $show_hidden { ls -a } else { ls }
  
  # Filter by query if provided
  let rows = if $query != '' {
    $rows | where name =~ $query
  } else {
    $rows
  }
  
  # Sort based on selected column
  let rows = match $sort {
    'modified' => ($rows | sort-by modified),
    'size' => ($rows | sort-by size),
    'type' => (
      $rows
      | each {|it| $it | insert kind (if $it.type == 'dir' { 0 } else { 1 }) }
      | sort-by kind name --ignore-case --natural
      | reject kind
    ),
    _ => ($rows | sort-by name --ignore-case --natural)
  }
  
  # Apply reverse if needed
  let rows = if $rev { $rows | reverse } else { $rows }
  
  # Display results
  if ($rows | is-empty) {
    ['🧙🏼‍♂️ nothing here'] | table -i false
  } else {
    $rows 
    | each {|it|
        let now = (date now)
        let age = ($now - $it.modified)
        let age_color = if $age < 1hr {
          'green_bold'
        } else if $age < 1day {
          'green'
        } else if $age < 1wk {
          'yellow'
        } else if $age < 4wk {
          'red'
        } else {
          'red_dimmed'
        }
        
        let relative_date = ($it.modified | date humanize)
        
        {
          name: (if $it.type == 'dir' { 
            $"(ansi blue_bold)($it.name)(ansi reset)" 
          } else { 
            $it.name 
          })
          type: $it.type
          size: $it.size
          modified: $"(ansi ($age_color))($relative_date)(ansi reset)"
        }
      }
    | table -i false
  }
}

