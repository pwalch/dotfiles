export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="micro"
export PAGER="bat"

alias zshc="$EDITOR ~/.zshrc_custom.zsh"
alias zshs="$EDITOR ~/.secrets.sh"

function tmuxbuffer () {
  # Open tmux buffer saved with PREFIX+S shortcut in text editor
  local TMUX_BUFFER="/tmp/tmux-buffer.txt"
  if [ ! -f "$TMUX_BUFFER" ]; then
    echo "[ERROR] Could not find file: $TMUX_BUFFER"
    return 1
  fi
  sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$TMUX_BUFFER"
  "$EDITOR" "$TMUX_BUFFER"
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

# SSH into a machine without the host key check (avoid "someone is doing something nasty" error)
alias sshinsecure="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# If we need to unalias entries from common-aliases from Oh-My-ZSH
# for COMMAND in l ll la; do unalias \$COMMAND; done
alias ls='exa' # ls
alias l='exa -lbFa --git' # list, size, type, git
alias ll='exa -lbGFa --git' # long list
alias llm='exa -lbGda --git --sort=modified' # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

alias lg=lazygit

alias vsc="code ."
alias vscn="code --new-window"
alias vscr="code --reuse-window"

# global standalone-venv auto-activation
export VIRTUAL_ENV_DISABLE_PROMPT=1  # no prompt prefix everywhere
export PATH="${HOME}/.standalone-venv/venv/bin:${PATH}"
export VIRTUAL_ENV="${HOME}/.standalone-venv/venv"
export PIPX_HOME="${HOME}/.standalone-venv/pipx_home"
export PIPX_BIN_DIR="${HOME}/.standalone-venv/pipx_bin"
export PATH="${PIPX_BIN_DIR}:$PATH"

eval $(thefuck --alias)
# To fix 'git push' with a new branch
export THEFUCK_PRIORITY="git_hook_bypass=1100"

WORKSPACE_DIR="$HOME/workspace"
alias wks="cd \"$WORKSPACE_DIR\""
mkdir -p "$WORKSPACE_DIR"
NOTES_DIR="${WORKSPACE_DIR}/dailynotes"
mkdir -p "$NOTES_DIR"
alias notesdir="cd \"$NOTES_DIR\""
alias todaynotes="$EDITOR "'${NOTES_DIR}/$(date +%Y%m%d)-notes.md'
alias yesternotes="$EDITOR "'${NOTES_DIR}/$(date -d "yesterday" +%Y%m%d)-notes.md'
alias weeknotes="$EDITOR "'${NOTES_DIR}/$(date -d "last Monday" +%Y%m%d)-notes-week.md'
DAILY_DIRS="${WORKSPACE_DIR}/dailydirs"
mkdir -p "$DAILY_DIRS"
alias todaydir='mkdir -p "${DAILY_DIRS}/$(date +%Y%m%d)-dailydir/" && cd "${DAILY_DIRS}/$(date +%Y%m%d)-dailydir/"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
