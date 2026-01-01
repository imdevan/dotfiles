# https://www.nushell.sh/book/configuration.html

# Hide the welcome prompt (equivalent to fish_greeting = '')
$env.config.show_banner = false
$env.config.table.mode = 'rounded'

source ~/.config/nushell/themes/catppucin.nu

# Custom prompt matching fish shell config
# Shows relative path with ~ for home, displays last 2 parts if path is long
$env.PROMPT_COMMAND = {||
  let home = ($nu.home-path)
  let path = (pwd)

  # Calculate relative path
  let display = (if ($path | str starts-with $home) {
    let rel = ($path | str replace $home "~")
    let parts = ($rel | path split)
    let count = ($parts | length)
    if $count > 2 { 
      $parts | last 2 | str join "/" 
    } else { 
      $rel 
    }
  } else {
    let parts = ($path | path split)
    let count = ($parts | length)
    if $count > 1 { 
      $parts | last 2 | str join "/" 
    } else { 
      $path 
    }
  })

  # Display the prompt without user/hostname information (blue color)
  $"(ansi blue)($display)(ansi reset)\n"
}

$env.PROMPT_COMMAND_RIGHT = ""

# Enable vi mode (equivalent to fish's bind \e\C-v vi-editing-mode)
$env.config = ($env.config | upsert edit_mode vi)

# Insert mode indicator (green ❯)
$env.PROMPT_INDICATOR_VI_INSERT = {||
  $"(ansi green)❯(ansi reset) "
}

# Normal mode indicator (yellow ❮)
$env.PROMPT_INDICATOR_VI_NORMAL = {||
  $"(ansi yellow)❮(ansi reset) "
}

# Fallback indicator when vi mode is off (green ❯)
$env.PROMPT_INDICATOR = {||
  $"(ansi green)❯(ansi reset) "
}

# Multiline continuation indicator
$env.PROMPT_MULTILINE_INDICATOR = {||
  "… "
}

$env.config = ($env.config | upsert completions {
  case_sensitive: false
  quick: true
  partial: true
})

