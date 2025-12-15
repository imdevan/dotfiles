# Auto-compile all function files on first load or when changed
for func_file in $dotfile_dir/functions/**/*.sh(N); do
    if [[ ! -f "${func_file}.zwc" ]] || [[ "$func_file" -nt "${func_file}.zwc" ]]; then
        zcompile "$func_file" 2>/dev/null
    fi
done

# Shared functions
source $dotfile_dir/functions/shared/colors.sh # colors should be loaded first
source $dotfile_dir/functions/shared/validators.sh
source $dotfile_dir/functions/shared/join_args.sh
source $dotfile_dir/functions/shared/has_flag.sh
source $dotfile_dir/functions/shared/alias_utils.sh
source $dotfile_dir/functions/shared/to_copy.sh

# Global function handler for zsh
source $dotfile_dir/functions/command_not_found_handler.sh

# Barrel file for functions
source $dotfile_dir/functions/localhost.sh
source $dotfile_dir/functions/github.sh
source $dotfile_dir/functions/facebook.sh
source $dotfile_dir/functions/random.sh
source $dotfile_dir/functions/node.sh
source $dotfile_dir/functions/new_function.sh

# Generated functions
source $dotfile_dir/functions/reset_node.sh
source $dotfile_dir/functions/search.sh
source $dotfile_dir/functions/npm_latest.sh
source $dotfile_dir/functions/post.sh
source $dotfile_dir/functions/make_directory.sh
source $dotfile_dir/functions/simulator.sh
source $dotfile_dir/functions/to_send.sh
source $dotfile_dir/functions/gpt.sh
source $dotfile_dir/functions/quick_note.sh
source $dotfile_dir/functions/open_github.sh
source $dotfile_dir/functions/scripts.sh
source $dotfile_dir/functions/make_file.sh
source $dotfile_dir/functions/encore_app_create.sh
source $dotfile_dir/functions/jobbies.sh
source $dotfile_dir/functions/echo_to.sh
source $dotfile_dir/functions/find_string.sh
source $dotfile_dir/functions/sto.sh
source $dotfile_dir/functions/re_run.sh
source $dotfile_dir/functions/math.sh
source $dotfile_dir/functions/docker_exec_it.sh
source $dotfile_dir/functions/clear_all_modules.sh

source $dotfile_dir/functions/function_utils.sh

source $dotfile_dir/functions/to_grep.sh

source $dotfile_dir/functions/fcd.sh

source $dotfile_dir/functions/aero_utils.sh

source $dotfile_dir/functions/ytdl.sh

source $dotfile_dir/functions/multi-agent-search.sh

source $dotfile_dir/functions/sh_utils.sh

source $dotfile_dir/functions/docker_utils.sh

source $dotfile_dir/functions/to_log.sh
