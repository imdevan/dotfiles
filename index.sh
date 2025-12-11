# Change this is you change the location of these dotfiles
dotfile_dir=~/dotfiles

# Add to top of ~/dotfiles/index.sh
for file in $dotfile_dir/functions/**/*.sh(N) $dotfile_dir/aliases.sh; do
    if [[ ! -f "${file}.zwc" ]] || [[ "$file" -nt "${file}.zwc" ]]; then
        zcompile "$file" 2>/dev/null
    fi
done

# Removed in favor of caching
# Import functions
source $dotfile_dir/functions/index.sh

# A bunch of aliases
source $dotfile_dir/aliases.sh
