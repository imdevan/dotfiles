# config file docs
# https://qutebrowser.org/doc/help/configuring.html
# https://github.com/news-s/Qutebrowser-config/blob/main/config.py
# https://qutebrowser.org/doc/help/settings.html
# Defualt bindings
# https://qutebrowser.org/doc/help/settings.html#bindings.default

import catppuccin

# Must load first
config.load_autoconfig()

path_to_start_page = "http://localhost:8081/"
# path_to_start_page = "https://github.com/news-s/Qutebrowser-config/blob/main/config.py"
# path_to_start_page = "https://qutebrowser.org/doc/quickstart.html"

# Keybinds
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("X", "undo")
config.bind("<Cmd-Alt-i>", "devtools right")
config.bind("<Cmd-Alt-b>", "devtools bottom")
config.bind("<Ctrl-t>", f"open {path_to_start_page}")

# Window Styles
c.window.hide_decoration = True
# c.window.transparent = True
# c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.statusbar.show = "in-mode"
c.tabs.show = "switching"
c.tabs.position = "top"
c.tabs.favicons.show = "pinned"
c.url.start_pages = path_to_start_page
c.content.fullscreen.window = True

# Search Engines
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "git": "https://github.com/search?q={}",
    "stack": "https://stackoverflow.com/search?q={}",
    "lol": "u.gg/lol/champions/{}/build",
}

# Aliases
c.aliases["chat"] = "open -t https://chat.openai.com"

# Defaults
c.content.javascript.enabled = True
c.content.autoplay = False
c.content.cookies.accept = "no-3rdparty"
c.content.geolocation = False
c.content.notifications.enabled = False

# Adblock
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
]

# Code Editor
c.editor.command = ["code", "{}"]

# Theme Config
# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, "macchiato", True)


# hints {{{
## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
c.colors.hints.bg = "#f5bde6"
# c.colors.hints.bg = "#1e2030"

## Font color for hints.
c.colors.hints.fg = "#1e2030"
# c.colors.hints.fg = "#cad3f5"

## Hints
c.hints.border = "1px solid " + "#ed8796"

## Font color for the matched part of hints.
c.colors.hints.match.fg = "#ed8796"
# }}}
# keyhints {{{
## Background color of the keyhint widget.
# c.colors.keyhint.bg = palette["mantle"]

## Text color for the keyhint widget.
# c.colors.keyhint.fg = palette["text"]

## Highlight color for keys to complete the current keychain.
# c.colors.keyhint.suffix.fg = palette["subtext1"]
# }}}

# Docs:
# https://qutebrowser.org/doc/help/configuring.html
# https://qutebrowser.org/doc/quickstart.html
# https://github.com/tinted-theming/base16-qutebrowser
# https://github.com/jtyers/qutebrowser-profile/blob/master/qutebrowser-profile
#
#
# Inspiration:
# https://github.com/news-s/Qutebrowser-config/blob/main/config.py
#
