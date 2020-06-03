export PS1="\w$ "
export LC_ALL=en_US.UTF-8

# configs home
export MY_CONFIGS_HOME="$HOME/.my/configs"

export XDG_CONFIG_HOME="$MY_CONFIGS_HOME"

# --files: List files that would be searched but do not search
export FZF_DEFAULT_OPTS='--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export FZF_DEFAULT_COMMAND='rg --files'
export RIPGREP_CONFIG_PATH="$MY_CONFIGS_HOME/.ripgreprc"

export NO_UPDATE_NOTIFIER=true

# Aliases
alias vim="nvim"
alias vi="nvim"
