## Feature 1: responsiveness
- [x] 1.1 add script to change status views based on terminal view width
  - [x] Create [responsive.sh](file:///home/devy/dotfiles/config/stow/tmux/.tmux/scripts/responsive.sh) to handle breakpoints (xxxs, xxs, xs, sm, md, lg) and dynamically toggle `status-right` and `window-status-format`
  - [x] Set hooks in [`tmux.conf`](file:///home/devy/dotfiles/config/stow/tmux/.config/tmux/tmux.conf) for `client-resized` and `client-attached`
script should live in /home/devy/dotfiles/config/stow/tmux/.tmux/scripts


breaks on small views with long file names

xxxs: 0-24
  - hide all by default.
  - show (only): 
    - active tmux window status badge
xxs: 24 ()
xs: 36 (standard left 1/3rd split mon: 45)
sm: 60 (1/4 width mon: 60)
  - show (only): 
    - active tmux window status badge
    - directory (current setup utilizing truncation script)
    - time
md: 90 (half width mon: 91)
  - show (only): 
    - all window status badges
    - directory (current setup utilizing truncation script)
    - time
lg: 120+ (3/4 width mon: 121)
  - show all (current)



## Feature 2: add script able hotkey alt+b to show battery
- [x] 2.1 Bind Alt+b to toggle battery status pill next to time
  - [x] Create [status_battery.sh](file:///home/devy/dotfiles/config/stow/tmux/.tmux/scripts/status_battery.sh) to format battery percentage & icon as a pill
  - [x] Create [toggle_battery.sh](file:///home/devy/dotfiles/config/stow/tmux/.tmux/scripts/toggle_battery.sh) to toggle battery visibility
  - [x] Integrate battery pill into [responsive.sh](file:///home/devy/dotfiles/config/stow/tmux/.tmux/scripts/responsive.sh) next to the time
  - [x] Bind `M-b` (Alt+b) to `toggle_battery.sh` in [`tmux.conf`](file:///home/devy/dotfiles/config/stow/tmux/.config/tmux/tmux.conf)
- [x] 2.2 use the following nerd font icons o represent battery power remaining, use seperate icons for charging, also listed

󰁹 - 95 - 100%
󰂂 - 90 - 95%
󰂁 - 80 - 90
󰂀 - 70 - 80
󰁿 - 60 - 70
󰁿 - 50 - 60
󰁾 - 40 - 50
󰁽 - 30 - 40
󰁼 - 20 - 30
󰁺 - 10 - 20
󰂃 - 10% or less
charging:
󰂅 - 95 - 100%
󰂋 - 90 - 95%
󰂊 - 80 - 90
󰢞 - 70 - 80
󰂉 - 60 - 70
󰢝 - 50 - 60
󰂈 - 40 - 50
󰂇 - 30 - 40
󰂆 - 20 - 30
󰢜 - 10 - 20
󰢟 - 10% or less


- [ ] 2.3 flash inverting color warning on 10% or less battery

## Feature 3: show battery in status if below 26 (assign via variable)


