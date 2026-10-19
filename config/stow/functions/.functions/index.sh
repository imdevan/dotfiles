#!/bin/zsh

# Auto-compile all function files on first load or when changed
# for func_file in $func_path/**/*.sh(N); do
#     if [[ ! -f "${func_file}.zwc" ]] || [[ "$func_file" -nt "${func_file}.zwc" ]]; then
#         zcompile "$func_file" 2>/dev/null
#     fi
# done
func_path="~/.functions"

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
source $func_path/facebook.sh
source $func_path/random.sh
source $func_path/node.sh
source $func_path/new_function.sh

# Generated functions
source $func_path/reset_node.sh
source $func_path/search.sh
source $func_path/npm_latest.sh
source $func_path/make_directory.sh
source $func_path/simulator.sh
source $func_path/to_send.sh
source $func_path/gpt.sh
source $func_path/quick_note.sh
source $func_path/open_github.sh
source $func_path/scripts.sh
source $func_path/make_file.sh
source $func_path/encore_app_create.sh
source $func_path/jobbies.sh
source $func_path/echo_to.sh
source $func_path/find_string.sh
source $func_path/sto.sh
source $func_path/re_run.sh
source $func_path/math.sh
source $func_path/docker_exec_it.sh
source $func_path/clear_all_modules.sh

source $func_path/function_utils.sh

source $func_path/to_grep.sh

source $func_path/fcd.sh

source $func_path/aero_utils.sh

source $func_path/ytdl.sh

source $func_path/multi-agent-search.sh

source $func_path/sh_utils.sh

source $func_path/docker_utils.sh

source $func_path/to_log.sh

source $func_path/which_lock.sh


source $func_path/list_all.sh

source $func_path/query_db.sh

source $func_path/yaz.sh

source $func_path/query_db.sh
source $func_path/real_fake_person.sh

source $func_path/reverse_stow.sh

source $func_path/brighten.sh

source $func_path/work_set_up.sh

source $func_path/split_dev.sh

source $func_path/breakout_windows.sh

source $func_path/devel.sh

source $func_path/tmuxinator.sh

source $func_path/split.sh

source $func_path/gcal.sh

source $func_path/tdpv.sh

source $func_path/simple_plan.sh

source $func_path/compression.sh

source $func_path/hours_from_now.sh

source $func_path/yx.sh

source $func_path/webify.sh
