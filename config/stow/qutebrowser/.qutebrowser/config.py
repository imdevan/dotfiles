import catppuccin

config.load_autoconfig()

path_to_start_page = "http://localhost:8081/"
# path_to_start_page = "https://github.com/news-s/Qutebrowser-config/blob/main/config.py"
# path_to_start_page = "https://qutebrowser.org/doc/quickstart.html"

c.window.hide_decoration = True
c.window.transparent = True

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.statusbar.show = "in-mode"
c.tabs.show = "switching"
c.tabs.position = "top"
c.tabs.favicons.show = "pinned"
c.url.start_pages = path_to_start_page


c.content.fullscreen.window = True

c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "git": "https://github.com/search?q={}",
    "stack": "https://stackoverflow.com/search?q={}",
    "lol": "u.gg/lol/champions/{}/build",
}

config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("X", "undo")
config.bind("<Ctrl-t>", f"open -t {path_to_start_page}")

c.aliases["chat"] = "open -t https://chat.openai.com"

c.content.javascript.enabled = True
c.content.autoplay = False
c.content.cookies.accept = "no-3rdparty"
c.content.geolocation = False
c.content.notifications.enabled = False

c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
]

c.editor.command = ["code", "{}"]
# Theme config
# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, "macchiato", True)


# docs:
# https://qutebrowser.org/doc/help/configuring.html
# https://qutebrowser.org/doc/quickstart.html
# https://github.com/tinted-theming/base16-qutebrowser
# https://github.com/jtyers/qutebrowser-profile/blob/master/qutebrowser-profile
#
#
# inspiration:
# https://github.com/news-s/Qutebrowser-config/blob/main/config.py
#
