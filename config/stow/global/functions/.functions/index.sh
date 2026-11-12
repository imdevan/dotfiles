#!/bin/zsh
# Auto-compile all function files on first load or when changed
# for func_file in $func_path/**/*.sh(N); do
#     if [[ ! -f "${func_file}.zwc" ]] || [[ "$func_file" -nt "${func_file}.zwc" ]]; then
#         zcompile "$func_file" 2>/dev/null
#     fi
# done
func_path="$HOME/.functions"
# Shared functions
source $func_path/shared/colors.sh # colors should be loaded first
source $func_path/shared/tmux_utils.sh
source $func_path/shared/validators.sh
source $func_path/shared/join_args.sh
source $func_path/shared/has_flag.sh
source $func_path/shared/alias_utils.sh
source $func_path/shared/to_copy.sh
source $func_path/shared/gummy.sh
source $func_path/shared/nu_alias.sh
source $func_path/shared/fzf_vim.sh
# Global function handler for zsh
source $func_path/command_not_found_handler.sh
# Barrel file for functions
source $func_path/localhost.sh
source $func_path/github.sh
source $func_path/random.sh
source $func_path/new_function.sh

source $func_path/scripts/aliases.zsh

# Generated functions
source $func_path/make_directory.sh
source $func_path/to_send.sh
source $func_path/gpt.sh
source $func_path/quick_note.sh
source $func_path/open_github.sh
source $func_path/make_file.sh
source $func_path/find_string.sh
source $func_path/re_run.sh
source $func_path/math.sh
source $func_path/docker_exec_it.sh
source $func_path/function_utils.sh
source $func_path/to_grep.sh
source $func_path/fcd.sh
source $func_path/ytdl.sh
source $func_path/docker_utils.sh
source $func_path/to_log.sh
source $func_path/query_db.sh
source $func_path/yaz.sh
source $func_path/query_db.sh
source $func_path/split_dev.sh
source $func_path/breakout_windows.sh
source $func_path/tmuxinator.sh
source $func_path/gcal.sh
source $func_path/tdpv.sh
source $func_path/yx.sh
source $func_path/webify.sh
