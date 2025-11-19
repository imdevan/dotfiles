import catppuccin

config.load_autoconfig()

path_to_start_page = "https://github.com/news-s/Qutebrowser-config/blob/main/config.py"
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

# Theme config
# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, 'macchiato', True)


# docs: 
# https://qutebrowser.org/doc/help/configuring.html
# https://qutebrowser.org/doc/quickstart.html
# https://github.com/tinted-theming/base16-qutebrowser
#
# default config: 
# https://gist.github.com/nightgrey/2ed92d362077843502e3dce639aae9c7
#
# inspiration:
# https://github.com/news-s/Qutebrowser-config/blob/main/config.py
# https://github.com/jtyers/qutebrowser-profile/blob/master/qutebrowser-profile
#
