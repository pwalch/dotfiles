export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"

# Disable autocomplete on scp, as it is always slow
zstyle ':completion:*' remote-access no

test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh" || true

# Overwriting robbyrussel's theme so it has newlines
PROMPT_NEWLINE=$'\n'
PROMPT="%{$(iterm2_prompt_mark)%}"
PROMPT+='${PROMPT_NEWLINE}%{$fg_bold[cyan]%}---- %c%{$reset_color%} $(git_prompt_info)'
PROMPT+="${PROMPT_NEWLINE}%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
if [[ "$OSTYPE" == 'darwin'* ]]; then
  # There is little space by default after the arrow without
  # this on macOS.
  PROMPT+=' '
fi


export PATH="$HOME/.local/bin:$PATH"
export EDITOR="micro"
export PAGER="bat"

alias zshc="$EDITOR ~/.zshrc_custom.zsh"
alias zshs="$EDITOR ~/.secrets.sh"

function tm () {
    edit_tmux_lines 10
}

function tmb () {
    edit_tmux_lines 50
}

function tmbb () {
    edit_tmux_lines 100
}

function edit_tmux_lines () {
    if [[ "$#" -ne 1 ]]; then
        echo "[ERROR] Invalid arguments, please pass the number of lines to tail."
        return 1
    fi

    local tail_lines="$1"

    local tmux_buffer_path="/tmp/tmux-buffer-micro.txt"
    if ! tmux capture-pane -p > "$tmux_buffer_path"; then
        echo "[ERROR] Could not save pane to: $tmux_buffer_path"
        return 1
    fi

    local head_lines="$(($tail_lines - 1))"
    sed '/^$/d' "$tmux_buffer_path" | \
       tail -n "$tail_lines" | head -n "$head_lines" | \
       micro
}

# De-comment and customize according to your most frequently used directories
# function dev-tmux () {
#   # Create a new tmux session with some windows opened at specific locations
#   # that I need frequently
#   local TMUX_SESSION_NAME="dev-tmux"
#   tmux new-session -d -s "$TMUX_SESSION_NAME" -n "firstwindow"
#   tmux new-window -t "${TMUX_SESSION_NAME}:" -n "todaydirs" -c "${TODAYDIRS}"
#   tmux new-window -t "${TMUX_SESSION_NAME}:" -n "my-frequent-dir-1" -c "${WORKSPACE_DIR}/frequent-dir-1"
#   tmux new-window -t "${TMUX_SESSION_NAME}:" -n "my-frequent-dir-2" -c "${WORKSPACE_DIR}/frequent-dir-2"
#   # Repeat at needed
#   tmux kill-window -t "${TMUX_SESSION_NAME}:firstwindow"
#   tmux select-window -t "${TMUX_SESSION_NAME}:todaydirs"
#   tmux attach-session -d
# }

alias dev-tmux-restart='tmux kill-server; dev-tmux'

# SSH into a machine without the host key check (avoid "someone is doing something nasty" error)
alias sshi="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
# Copy my public key to clipboard to share it quickly
alias pk="cat $HOME/.ssh/id_ed25519.pub | tr -d '\n' | clipcopy"
# Open my SSH config
alias sshc="$EDITOR $HOME/.ssh/config"
# Open my known-hosts file
alias sshkh="$EDITOR $HOME/.ssh/known_hosts"
# Open my authorized_keys file
alias sshak="$EDITOR $HOME/.ssh/authorized_keys"
# List authorized_keys names / comments
alias sshakl="cat ~/.ssh/authorized_keys | grep -Eo ' \S+\$' | grep -Eo '\S+'"

# This script was automatically generated by the broot program
# More information can be found in https://github.com/Canop/broot
# This function starts broot and executes the command
# it produces, if any.
# It's needed because some shell commands, like `cd`,
# have no useful effect if executed in a subshell.
function br {
    f=$(mktemp)
    (
        set +e
        broot --outcmd "$f" "$@"
        code=$?
        if [ "$code" != 0 ]; then
            rm -f "$f"
            exit "$code"
        fi
    )
    code=$?
    if [ "$code" != 0 ]; then
        return "$code"
    fi
    d=$(<"$f")
    rm -f "$f"
    eval "$d"
}

alias rr="ranger"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
eval "$(zoxide init zsh)"

eval "$(direnv hook zsh)"

# Always enable colored "grep" output
alias grep='grep --color=auto '

# copy/move ask for permission
alias cp='cp -i'
alias mv='mv -i'

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias sed="gsed"
    alias date="gdate"
fi

# Modern tools replace old ones
alias cat="bat --paging never --plain"
alias catp="bat"

alias rg="rg --sort-files"

# If we need to unalias entries from common-aliases from Oh-My-ZSH
for COMMAND in l la ll lsa; do unalias "$COMMAND"; done
alias ls='eza' # ls
alias l='eza --all --long --binary --git --classify --color-scale --hyperlink --group-directories-first --time-style=long-iso --octal-permissions --header --group'

alias lg=lazygit

alias vsc="code --profile 'pwalch' ."
alias vscn="code --profile 'pwalch' --new-window"
alias vscr="code --profile 'pwalch' --reuse-window"

# global lonesnake auto-activation
export PATH="${HOME}/.lonesnake/venv/bin:${PATH}"

# By default, pipx stores its files in "~/.local/pipx" and "~/.local/bin", but we
# configure it to use sub-directories of the standalone environment:
# "~/.lonesnake/pipx_bin" and "~/.lonesnake/pipx_home". Thanks to this,
# we keep everything related to the global environment in the same place.
export PIPX_HOME="${HOME}/.lonesnake/pipx_home"
export PIPX_BIN_DIR="${HOME}/.lonesnake/pipx_bin"
export PATH="${PIPX_BIN_DIR}:${PATH}"

# Print direnv activation instructions for lonesnake
# Usage: lonesnake-print-activation >> .envrc
function lonesnake-print-activation() {
cat << EOM
# lonesnake auto-activation for the project directory
lonesnake_dir="\${PWD}/.lonesnake"
PATH_add "\${lonesnake_dir}/venv/bin"
export VIRTUAL_ENV="\${lonesnake_dir}/venv"

# Solve errors involving "Python.h not found" when building
# Python extensions with a lonesnake environment.
parent_include_dir="\${lonesnake_dir}/interpreter/usr/local/include"
if [[ -d "\$parent_include_dir" ]]; then
  include_dir_name=\$(find "\$parent_include_dir" \
    -mindepth 1 -maxdepth 1 -type d -name "python3.*" \
    -exec basename {} \;)
  path_add CPATH "\${parent_include_dir}/\${include_dir_name}"
fi
EOM
}

# Safeguard shim against accidental 'pip install' to
# the global lonesnake environment.
# Call '~/.lonesnake/venv/bin/pip' to bypass.
function pip () {
  if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "[ERROR] Cannot run 'pip' command outside" \
      "of a VIRTUAL_ENV."
    return 1
  fi

  local active_pip=""
  if ! active_pip="$(whence -p pip)"; then
    echo "[ERROR] There is no 'pip' command in PATH:" \
      "${PATH}"
    return 1
  fi

  local global_pip=""
  global_pip="${HOME}/.lonesnake/venv/bin/pip"
  if [[ -f "$global_pip" ]] && \
      [[ "$active_pip" == "$global_pip" ]]; then
    echo "[ERROR] Cannot run 'pip' command with global" \
        "environment: ${global_pip}"
    return 1
  fi

  command pip "$@"
}

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval $(thefuck --alias)
# To fix 'git push' with a new branch
export THEFUCK_PRIORITY="git_hook_bypass=1100"

WORKSPACE_DIR="$HOME/workspace"
alias wks="cd \"$WORKSPACE_DIR\""
mkdir -p "$WORKSPACE_DIR"
DAILY_DIRS="${WORKSPACE_DIR}/dailydirs"
mkdir -p "$DAILY_DIRS"
alias todaydir='mkdir -p "${DAILY_DIRS}/$(date +%Y%m%d)-dailydir/" && cd "${DAILY_DIRS}/$(date +%Y%m%d)-dailydir/"'

alias dwl='cd $HOME/Downloads'

# print iTerm shortcuts
function iii () {
cat <<EOF
Copy mode:
- enter copy mode: CMD+SHIFT+C
- select full line: SHIFT+V
- start selecting: V
- quit copy mode: CTRL+SPACE

Shortcuts:
- copy last command output: CMD+SHIFT+A
- find next: CMD+G
EOF
}
