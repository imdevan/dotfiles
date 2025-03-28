#!/bin/sh

# Function to create a new bash function
function new_function() {
    # Check if function name is provided
    if [ -z "$1" ]; then
        echo "Usage: new_function <function_name> [description]"
        return 1
    fi

    # Get the function name and convert to lowercase
    function_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    function_file="$dotfile_dir/functions/${function_name}.sh"
    function_index_file="$dotfile_dir/functions/index.sh"
    
    # Get the description if provided, otherwise use default
    description=${2:-"[Add description here]"}

    # Check if file already exists
    if [ -f "$function_file" ]; then
        echo "Error: Function file '$function_file' already exists"
        return 1
    fi

    # Create alias by taking first letter of each word
    alias_name=$(echo "$function_name" | awk -F'_' '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')

    # Create the function file with basic structure
    cat > "$function_file" << EOF
#!/bin/sh

# Function: ${function_name}
# Description: ${description}
# Usage: ${function_name} [arguments]
# Alias: ${alias_name}

function ${function_name}() {
    # Function implementation goes here
    echo "Function ${function_name} called"
}

# Create alias
alias ${alias_name}="${function_name}"
EOF

    # Make the file executable
    chmod +x "$function_file"

    # Add source line to index.sh if it doesn't already exist
    if ! grep -q "source \$dotfile_dir/functions/${function_name}.sh" $function_index_file; then
        echo "" >> $function_index_file
        echo "source \$dotfile_dir/functions/${function_name}.sh" >> $function_index_file
    fi

    # Open the file in VS Code
    code "$dotfile_dir/functions/${function_name}.sh"

    echo "Created new function file: $function_file"
    echo "Added to index.sh and opened in VS Code"
    echo "Created alias: ${alias_name} -> ${function_name}"
}

# Alias for new_function
alias nf="new_function"

