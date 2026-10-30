references:
https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow

packages are grouped by os under `~/dotfiles/config/stow/`:
- `global` - stowed on every machine
- `macos` - stowed on mac only
- `omarchyos` - stowed on omarchy (arch) only

1. stow the stow config files

`stow -d ~/dotfiles/config/stow/global -t ~/ stowrc`

2. test that the stow config is working

```
cd ~/dotfiles/config/stow/global
stow -nv */
```

3. run stow for each group that applies to this machine

```
cd ~/dotfiles/config/stow/global && stow */
cd ~/dotfiles/config/stow/omarchyos && stow */   # or macos
```
