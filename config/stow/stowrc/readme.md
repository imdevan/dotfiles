# using this directory: 

references:
https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow

1. stow the stow config files

`stow -t ~/ ~/dotfiles/config/stow/stowrc/`

stow will now target folders in this directory

2. test that the stow config is working 

```
cd ~/dotfiles/config/stow/
stow -nv *
```

3. run stow

```
stow *
```
