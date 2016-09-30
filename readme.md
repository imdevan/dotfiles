# Dot files - Beta

# Welcome to my beta dotfiles branch

# Be weary I promise no maintained functionality here


tbh I know very little about dot file directory architecture.

`index.sh` Is the main file that all other files are included in.

### Installation

**Step 1**
Clone the repository into `.dotfiles` in your root directory

```
cd ~
git clone https://github.com/imdevan/dotfiles-boilerplate.git .dotfiles
```

**Step 2**  
Add `source ~/.dotfiles/index.sh` to the end of your `.bashrc` or `.zshrc` file

If you don't have a `.bashrc` file in your root directory, you can create one


**Step 3**
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
