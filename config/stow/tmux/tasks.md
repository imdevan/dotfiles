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



## Feature 2: show battery in status if below 26 (assign via variable)


