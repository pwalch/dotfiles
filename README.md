# dotfiles

This repo contains my dotfiles and is managed by [chezmoi](https://github.com/twpayne/chezmoi).

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply pwalch
```

## Installation instructions for Mac

### Foundation

After the first boot, perform all the possible OS updates
- major macOS upgrades in `App Store`
- minor upgrades in `Software Updates`
- reboot

Configure Mac settings:
- General: set `Show scroll bars` to `Always`
- `Battery > Power Adapter`: turn display off after 15 min on battery, after 1h for power adapter
- `Trackpad > Scroll & Zoom` > uncheck `Scroll direction: Natural`
- `Keyboard`: set `Key Repeat` to fastest and `Delay until Repeat` to shortest
- `Dock & Menu Bar`: set a small size, set `Position on screen` to `right` and set `Automatically hide and show the Dock`
- `Mission Control`: deactivate `ALT-DOWN` and `ALT-UP` by replacing them with `-`

Install Xcode command-line tools and Brew:
- `xcode-select --install`
- reboot
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- close and re-open terminal

### Terminal

- `brew install --cask iterm2`
- `brew install zsh-completions tmux`
- install tmux Powerline font: [GitHub link](https://github.com/powerline/fonts/blob/master/FiraMono/FuraMono-Regular%20Powerline.otf)
- `Preferences > Profiles > Text` and select `Fira Mono for Powerline`
- `Preferences > General > Selection`: check `Applications in terminal may access keyboard`
- install oh-my-zsh
  - `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- close and re-open terminal
- install some oh-my-zsh extensions
  - `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
  - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
  - `git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use`
- close and re-open terminal
- `cd ~`
- install Tmux and gpakosz
  - `git clone https://github.com/gpakosz/.tmux.git`
  - `ln -s -f .tmux/.tmux.conf`
- apply `chezmoi`
  - `sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply pwalch`

### GUI applications

```bash
brew install --cask google-chrome firefox \
    rectangle flycut flameshot \
    visual-studio-code pycharm-ce docker \
    thunderbird obsidian vlc gimp zoom libreoffice \
    tailscale
```

- Rectangle: start app and set up permissions, set shortcuts for left/right half, next/previous display and fullscreen, launch on login
- Chrome: make default browser, disable form autofill and password management, install `uBlock Origin`, `HTTPS Everywhere` and `LastPass`
- Flycut: start app and set up permissions, set shortcut to CMD + SHIFT + K, launch on login (https://github.com/TermiT/Flycut/issues/206)
- Flameshot: start app and try to make a screenshot to trigger permissions request
- Thunderbird: set up email accounts
  - Gmail: `imap.gmail.com:993`, `smtp.gmail.com:993` with email address as user name and application password as password
- Zoom: start app and try to get audio, video and share screen, which will trigger permissions request and require restarting the app
- PyCharm: start app and set it up
- GIMP: start app as it takes longer the first time

VS Code:
- install extensions
  - GitLens
  - Permute Lines
  - GoLang
  - HashiCorp Terraform
  - VSCode Docker + Remote SSH + Remote Containers
  - Python (already integrated normally)
  - indent rainbow
  - RedHat Ansible
  - RedHat YAML
  - Even Better TOML
  - cmake
  - Error Lens
  - VSCode Icons
  - TODO Highlight
- set settings in VSCode UI

```json
{
    "editor.minimap.enabled": false,
    "editor.rulers": [89],
    "files.insertFinalNewline": true,
    "files.trimFinalNewlines": true,
    "files.trimTrailingWhitespace": true,
    "telemetry.telemetryLevel": "off",
    "terminal.integrated.sendKeybindingsToShell": true,
    "workbench.editor.enablePreview": false,
    "workbench.iconTheme": "vscode-icons"
}
```

### Terminal applications

```bash
brew install \
    openssl readline sqlite3 xz zlib \
    micro bat sd the_silver_searcher \
    fd exa tree broot ranger fzf zoxide \
    direnv git-lfs diff-so-fancy lazygit gitui shellcheck mosh \
    nvm lonesnake \
    coreutils procs dust ctop lazydocker viddy \
    ffmpeg ipmitool docker-credential-helper-ecr
```

`micro ~/.config/micro/settings.json`:

```json
{
    "Alt-/": "lua:comment.comment",
    "CtrlUnderscore": "lua:comment.comment",
    "Ctrl-d": "Delete",
    "tabstospaces": true
}
```

Node
- `nvm install 16`

Python
- `cd ~`
- `lonesnake`
- close and re-open terminal
- check that `which python` points to `~/.lonesnake/venv/bin`
- `pip install pipx`
- `for PACKAGE in thefuck httpie magic-wormhole black isort flake8; do pipx install "$PACKAGE"; done`

AWS
- install AWSCLI with [tutorial](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- `aws configure` and enter default keys
- `mkdir -p ~/.docker && echo '{"credsStore": "ecr-login"}' > ~/.docker/config.json`
- workaround for [Docker for Mac issue](https://github.com/docker/for-mac/issues/6295)
  - `alias docker-configure-ecr="mkdir -p ~/.docker && echo '{\"credsStore\": \"ecr-login\"}' > ~/.docker/config.json"`
