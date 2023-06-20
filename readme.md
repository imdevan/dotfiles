# Dot files

tbh I know very little about dot file directory architecture.

`index.sh` Is the main file that all other files are included in.

## Installation

#### Step 1

Install zsh & oh-my-zsh

#### Step 2

Clone the repository into your root directory

```
cd ~
git clone https://github.com/imdevan/dotfiles.git
```

#### Step 3

If you are using bash: 
- Replace (or append to) the contents of `~/.bashrc` with `source ~/dotfiles/index.sh`
- Comment out the `source $dotfile_dir/.zsh-config` line from `~/dotfiles/index.sh`

If you are using oh-my-zsh: 
- Replace (or append to) the contents of `~/.zshrc` with `source ~/dotfiles/index.sh`

#### Step 4

Restart you're terminal

### notes

- `vars` contains files that are used throughout
- All other files function independently of each other
- Leave an issue if you have questions or... issues

## In this repo

### Master branch
Most complete version of my dotfiles, that doesn't make any assumption

### Boilerplate branch
Very minimal for people who don't know a lot about bash scripting

### Beta branch
What I'm currently using, no promises 🙏
