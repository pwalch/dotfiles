export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"

# Disable autocomplete on scp, as it is always slow
zstyle ':completion:*' remote-access no

# Brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Overwriting robbyrussel's theme so it has newlines
PROMPT_NEWLINE=$'\n'
PROMPT=""
PROMPT+='${PROMPT_NEWLINE}%{$fg_bold[cyan]%}---- %c%{$reset_color%} $(git_prompt_info)'
PROMPT+="${PROMPT_NEWLINE}%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
if [[ "$OSTYPE" == 'darwin'* ]]; then
  # There is little space by default after the arrow without
  # this on macOS.
  PROMPT+=' '
fi

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="micro"

alias zshc="$EDITOR ~/.zshrc_custom.zsh"
alias zshs="$EDITOR ~/.secrets.sh"

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

eval "$(fzf --zsh)"
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
alias cat="bat --paging=never"
alias catp="bat"

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

alias dwl='cd $HOME/Downloads'
