# Dotfiles

My personal dotfiles, use or edit at your own risk. Working on a more public option if people want to take inspiration.

`index.sh` Is the main file that all other files are included in.

### tl;dr; Installation

**Step 1**
Clone the repository into your root directory

```bash
cd ~
git clone https://github.com/imdevan/dotfiles.git
```

**Step 2**  
```bash
chmod +x ~/dotfiles/config/setup/boot_strap.sh
~/dotfiles/config/setup/boot_strap.sh
```

**Step 3**
Restart you're terminal

**Optional Step 4**
For some of the github funcationality you will have to add

```
GIT_SSH_URL=git@github.com:<your_github_username>
```

And have `ssh` setup w/ your github account.


### In depth Installation

See [/docs/setup.md](/docs/setup.md) for more information ;) 


<!-- ## In this repo -->

<!-- TODO: implement this 👇 -->
<!-- ### Master branch -->
<!-- Most complete version of my dotfiles, that doesn't make any assumption -->
<!---->
<!-- ### Boilerplate branch -->
<!-- Very minimal for people who don't know a lot about bash scripting -->
<!---->
<!-- ### Beta branch -->
<!-- What I'm currently using, no promises 🙏 -->

## Folder breakdown

```
├── aliases.sh .............. commonly used shortcuts
│
├── config
│   ├── code ................ default config for vscode based editors
│   │                         configs are loaded from stow to actual editor below
│   ├── homebrew ............ homebrew backups
│   ├── keyboard-maestro .... keyboard maestro backups
│   ├── oh-my-posh .......... zsh theme config
│   ├── macos ............... macos config script
│   ├── setup ............... scripts intended to run once
│   ├── stow ................ GNU stow configs
│   │   ├── aerospace
│   │   ├── cspell
│   │   ├── cursor
│   │   ├── nvim
│   │   ├── qutebrowser
│   │   ├── sketchybar
│   │   ├── stowrc
│   │   ├── tmux
│   │   ├── vscode
│   │   └── zsh
│   └── vimium .............. chrome extension backup
│
├── docs .................... make it make sense
│   ├── keybinds
│   │   └── hotkeys.md ...... hotkeys across most used apps
│   ├── possible-future.md  . future planning
│   └── setup.md ............ environment setup guide
│
├── functions ............... utility functions, like aliases with more "pow!"
│   ├── shared .............. shared functions, used across other functions
│   ├── index.sh ............ barrel function called from index
│   └── ...
│
├── index.sh ................ ties the room together
│
└── readme.md ............... you're reading it
```

## Acknowledgements

https://github.com/mathiasbynens/dotfiles/tree/main
https://github.com/thoughtbot/dotfiles
