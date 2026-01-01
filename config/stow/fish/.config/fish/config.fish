# https://fishshell.com/docs/current/language.html#configuration

if status is-interactive
    # Apply the Catppuccin theme
    fish_config theme choose "Catppuccin Macchiato"

    # Set the number of directories to display (e.g., show up to 3 directories)
    set -g tide_prompt_dir_length 1
    set -g tide_prompt_dir_max_length 1

    # Hide the welcome prompt (equivalent to nushell's show_banner = false)
    set fish_greeting ''

    # Enable vi mode (equivalent to nushell's edit_mode vi)
    fish_vi_key_bindings
end
