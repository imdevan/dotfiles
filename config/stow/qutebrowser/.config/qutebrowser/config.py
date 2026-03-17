# config file docs
# https://qutebrowser.org/doc/help/configuring.html
# https://github.com/news-s/Qutebrowser-config/blob/main/config.py
# https://qutebrowser.org/doc/help/settings.html
# Defualt bindings
# https://qutebrowser.org/doc/help/settings.html#bindings.default

import catppuccin

# Must load first
config.load_autoconfig()

path_to_start_page = "https://devan.gg/cosmic"
# path_to_start_page = "https://chatgpt.com/chat"
# path_to_start_page = "https://github.com/news-s/Qutebrowser-config/blob/main/config.py"
# path_to_start_page = "https://qutebrowser.org/doc/quickstart.html"

# Keybinds
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("X", "undo")
config.bind("<Cmd-Alt-i>", "devtools right")
config.bind("<Cmd-Alt-b>", "devtools bottom")
config.bind("<Ctrl-t>", f"open {path_to_start_page}")
config.bind("<Cmd-Shift-W>", "close")  # For macOS
config.bind(
    "<Ctrl-w>", "spawn --userscript download-wallhaven ;; later 2000 tab-close"
)  # Download wallhaven wallpaper and close tab after 2 seconds

# Window Styles
c.window.hide_decoration = True
# c.window.transparent = True
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.bg = "rgba(0,0,0,0)"

c.colors.webpage.preferred_color_scheme = "dark"
c.statusbar.show = "in-mode"
c.tabs.show = "switching"
c.tabs.position = "top"
c.tabs.favicons.show = "pinned"
c.url.start_pages = path_to_start_page
c.content.fullscreen.window = True

# Search Engines
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "d": "https://devan.gg/{}",
    "t": "https://devan.gg/t?{}",
    "dh": "https://devanhuapaya.com/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "git": "https://github.com/search?q={}",
    "stack": "https://stackoverflow.com/search?q={}",
    "gpt": "https://chatgpt.com/?q={}",
    "cla": "https://claude.ai/new?q={}",
    "lol": "u.gg/lol/champions/{}/build",
    "re": "https://github.com/imdevan/{}",
    "l": "localhost:{}000",
    "ll": "localhost:{}",
    "4": "localhost:432{}",
    "l8": "localhost:808{}",
    "wall": "https://wallhaven.cc/search?q={}&categories=110&purity=111&atleast=1920x1080&ratios=landscape&sorting=views&order=desc",
    "gt": "https://www.ultimate-guitar.com/search.php?title={}&type%5B0%5D=300&page=1&order=myweight",
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
