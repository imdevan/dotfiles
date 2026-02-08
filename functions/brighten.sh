#!/bin/bash

# Function: brighten
# Description: Adjust color brightness with format-aware brightness modes
# Usage: brighten [color] [brightness]
# Alias: br

# Helper function to convert HSL to RGB using Python
function hsl_to_rgb() {
    python3 -c "
import colorsys
h, s, l = $1 / 360.0, $2 / 100.0, $3 / 100.0
r, g, b = colorsys.hls_to_rgb(h, l, s)
if '$4' == 'r': print(int(r * 255))
elif '$4' == 'g': print(int(g * 255))
elif '$4' == 'b': print(int(b * 255))
"
}

function brighten() {
    if [ $# -lt 2 ]; then
        g_dang "Usage: brighten [color] [brightness]
  color: hex (#fff or fff), rgb(r,g,b), rgba(r,g,b,a), hsl(h,s,l), hsla(h,s,l,a)
  
  brightness modes (all formats):
    percent (50%): increase by percentage
    fraction (0.5, 1.5): multiply by fraction
    integer (10, -5): add/subtract value
  
  brightness ranges by color format:
    hex: integer 0-16 (0-F) per channel
    rgb: integer 0-255 per channel
    hsl: integer 0-100 for lightness"
        return 1
    fi

    local color="$1"
    local brightness="$2"
    local alpha=""
    
    # Detect brightness format
    local brightness_mode brightness_value
    if [[ "$brightness" =~ ^-?[0-9]+%$ ]]; then
        # Percent format: 50% -> increase by 50%
        brightness_mode="percent"
        brightness_value="${brightness%\%}"
    elif [[ "$brightness" =~ ^[0-9]*\.[0-9]+$ ]]; then
        # Float format: 0.5, 1.5, 2.0 -> multiply
        brightness_mode="fraction"
        brightness_value="$brightness"
    elif [[ "$brightness" =~ ^-?[0-9]+$ ]]; then
        # Integer format: 1, 2, -1 -> add/subtract
        brightness_mode="integer"
        brightness_value="$brightness"
    else
        g_dang "Error: Invalid brightness format"
        return 1
    fi
    
    # Detect and parse color format
    local r g b h s l format
    local -a matches  # For zsh compatibility
    
    if [[ "$color" =~ ^#([0-9a-fA-F]{6})([0-9a-fA-F]{2})?$ ]]; then
        # Hex format with optional alpha (must start with #)
        # Use match array for zsh, BASH_REMATCH for bash
        matches=("${match[@]:-${BASH_REMATCH[@]}}")
        local hex="${matches[1]}"
        alpha="${matches[2]}"
        r=$((16#${hex:0:2}))
        g=$((16#${hex:2:2}))
        b=$((16#${hex:4:2}))
        format="hex"
    elif [[ "$color" =~ ^#?([0-9a-fA-F]{3})$ ]]; then
        # Short hex format (with or without #)
        matches=("${match[@]:-${BASH_REMATCH[@]}}")
        local hex="${matches[1]}"
        r=$((16#${hex:0:1}${hex:0:1}))
        g=$((16#${hex:1:1}${hex:1:1}))
        b=$((16#${hex:2:1}${hex:2:1}))
        format="hex"
    elif [[ "$color" =~ ^rgba?\(([0-9]+),\s*([0-9]+),\s*([0-9]+)(,\s*([0-9.]+))?\)$ ]]; then
        # RGB/RGBA format
        matches=("${match[@]:-${BASH_REMATCH[@]}}")
        r="${matches[1]}"
        g="${matches[2]}"
        b="${matches[3]}"
        alpha="${matches[5]}"
        format="rgb"
    elif [[ "$color" =~ ^hsla?\(([0-9]+),\s*([0-9]+)%?,\s*([0-9]+)%?(,\s*([0-9.]+))?\)$ ]]; then
        # HSL/HSLA format
        matches=("${match[@]:-${BASH_REMATCH[@]}}")
        h="${matches[1]}"
        s="${matches[2]}"
        l="${matches[3]}"
        alpha="${matches[5]}"
        format="hsl"
    else
        g_dang "Error: Unsupported color format"
        return 1
    fi
    
    # Apply brightness adjustment based on format and mode
    local new_r new_g new_b new_h new_s new_l
    
    if [ "$format" = "hsl" ]; then
        # For HSL, adjust the L value directly
        new_h="$h"
        new_s="$s"
        
        if [ "$brightness_mode" = "percent" ]; then
            # Increase L by percentage: L + (L * percent/100)
            new_l=$(echo "scale=0; l=$l * (1 + $brightness_value / 100); if (l > 100) 100 else if (l < 0) 0 else l / 1" | bc)
        elif [ "$brightness_mode" = "fraction" ]; then
            # Multiply L by fraction
            new_l=$(echo "scale=0; l=$l * $brightness_value; if (l > 100) 100 else if (l < 0) 0 else l / 1" | bc)
        else
            # Add integer to L (0-100 range)
            new_l=$(echo "scale=0; l=$l + $brightness_value; if (l > 100) 100 else if (l < 0) 0 else l / 1" | bc)
        fi
        
        # Convert HSL to RGB for display
        r=$(hsl_to_rgb $h $s $l r)
        g=$(hsl_to_rgb $h $s $l g)
        b=$(hsl_to_rgb $h $s $l b)
        new_r=$(hsl_to_rgb $new_h $new_s $new_l r)
        new_g=$(hsl_to_rgb $new_h $new_s $new_l g)
        new_b=$(hsl_to_rgb $new_h $new_s $new_l b)
        
    elif [ "$format" = "hex" ]; then
        # For hex, brightness is 0-16 (0-F) added to each color pair
        if [ "$brightness_mode" = "percent" ]; then
            # Increase by percentage
            new_r=$(echo "scale=0; r=$r * (1 + $brightness_value / 100); if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g * (1 + $brightness_value / 100); if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b * (1 + $brightness_value / 100); if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        elif [ "$brightness_mode" = "fraction" ]; then
            # Multiply by fraction
            new_r=$(echo "scale=0; r=$r * $brightness_value; if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g * $brightness_value; if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b * $brightness_value; if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        else
            # Add integer (0-16 range for hex)
            new_r=$(echo "scale=0; r=$r + $brightness_value; if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g + $brightness_value; if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b + $brightness_value; if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        fi
        
    else
        # For RGB, brightness is 0-255 added to all values
        if [ "$brightness_mode" = "percent" ]; then
            # Increase by percentage
            new_r=$(echo "scale=0; r=$r * (1 + $brightness_value / 100); if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g * (1 + $brightness_value / 100); if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b * (1 + $brightness_value / 100); if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        elif [ "$brightness_mode" = "fraction" ]; then
            # Multiply by fraction
            new_r=$(echo "scale=0; r=$r * $brightness_value; if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g * $brightness_value; if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b * $brightness_value; if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        else
            # Add integer (0-255 range for RGB)
            new_r=$(echo "scale=0; r=$r + $brightness_value; if (r > 255) 255 else if (r < 0) 0 else r / 1" | bc)
            new_g=$(echo "scale=0; g=$g + $brightness_value; if (g > 255) 255 else if (g < 0) 0 else g / 1" | bc)
            new_b=$(echo "scale=0; b=$b + $brightness_value; if (b > 255) 255 else if (b < 0) 0 else b / 1" | bc)
        fi
    fi
    
    # Format output based on input format
    local old_color new_color
    if [ "$format" = "hex" ]; then
        old_color=$(printf "#%02x%02x%02x" $r $g $b)
        new_color=$(printf "#%02x%02x%02x" $new_r $new_g $new_b)
        [ -n "$alpha" ] && old_color="${old_color}${alpha}"
    elif [ "$format" = "hsl" ]; then
        if [ -n "$alpha" ]; then
            old_color="hsla($h, $s%, $l%, $alpha)"
            new_color="hsla($new_h, $new_s%, $new_l%, $alpha)"
        else
            old_color="hsl($h, $s%, $l%)"
            new_color="hsl($new_h, $new_s%, $new_l%)"
        fi
    else
        if [ -n "$alpha" ]; then
            old_color="rgba($r, $g, $b, $alpha)"
            new_color="rgba($new_r, $new_g, $new_b, $alpha)"
        else
            old_color="rgb($r, $g, $b)"
            new_color="rgb($new_r, $new_g, $new_b)"
        fi
    fi
    
    # Copy to clipboard (try multiple clipboard commands)
    if command -v xclip &> /dev/null; then
        echo -n "$new_color" | xclip -selection clipboard
    elif command -v pbcopy &> /dev/null; then
        echo -n "$new_color" | pbcopy
    elif command -v wl-copy &> /dev/null; then
        echo -n "$new_color" | wl-copy
    fi
    
    # Print results with color formatting using gummy
    if command -v gum &> /dev/null; then
        g_suc "Old: $(gum style --foreground "$old_color" "$old_color")
New: $(gum style --foreground "$new_color" "$new_color") (copied to clipboard)"
    else
        # Fallback to ANSI colors if gum not available
        echo -e "\033[32m✓\033[0m Old: \033[38;2;${r};${g};${b}m${old_color}\033[0m"
        echo -e "\033[32m✓\033[0m New: \033[38;2;${new_r};${new_g};${new_b}m${new_color}\033[0m (copied to clipboard)"
    fi
}

# Create alias
alias br="brighten"
