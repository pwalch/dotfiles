# dotfiles

Here are instructions to reproduce my development environment on macOS, along with all my dotfiles.

Check out the companion blog post: [Your dev environment is your ideal supermarket](https://pwal.ch/posts/2021-12-27-dev-env-dotfiles/).

## Installation instructions for Mac

### Foundation

After the first boot, perform all the possible OS updates:
- install major and minor upgrades in System Preferences > Software Updates, then reboot and check again until there are no more updates
- in terminal, install XCode command line tools: `xcode-select --install`
- check again System Preferences > Software Updates and install updates if available, then reboot again. Repeat until there are no more updates.
- System Preferences > Security and Privacy > FileVault: click "Turn On FileVault" then set a recovery key and save it in password manager

Configure Mac settings:
- General: set `Show scroll bars` to `Always`
- `Battery > Power Adapter`: turn display off after 15 min on battery, after 1h for power adapter
- `Trackpad > Scroll & Zoom` > uncheck `Scroll direction: Natural`
- `Keyboard > Text Input > Edit...` then disable "Use smart quotes and dashes"
- `Keyboard`: set `Key Repeat` to fastest and `Delay until Repeat` to shortest
- `Keyboard` > `Shortcuts`
  - `Input Sources`: uncheck `Select the previous ...` and `Select the next ...`
  - `Keyboard` > `Move focus to active or next window`: press `CMD + <`
- `Dock & Menu Bar`: set a small size, set `Position on screen` to `right` and set `Automatically hide and show the Dock`
- remove all optional icons from Dock
- `Dock & Menu Bar > Battery`: show percentage
- `Mission Control`: deactivate `ALT-DOWN` and `ALT-UP` by replacing them with `-`
- `Screenshot` app: go to `Options > Save to` and select `Other location`, then create folder in `~/workspace` called `screenshots` and put it there

### Terminal

Install Brew:
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- close and re-open Terminal

- `brew install --cask iterm2`
- close Terminal app and open iTerm app
- Security & Privacy > Privacy > Full Disk Access > add iTerm
- generate SSH key
  - `ssh-keygen -t ed25519 -C "$(date "+%Y%m%d")-DEVICE-NAME"`
- `brew install zsh-completions tmux`
- install tmux Powerline font: [GitHub link](https://github.com/powerline/fonts/blob/master/FiraMono/FuraMono-Regular%20Powerline.otf)
- `Preferences > Profiles > Text` and select `Fira Mono for Powerline`
- `Preferences > Profiles > Keys` and do `Load Preset...` then `Natural Text Editing`
- `Preferences > General > Selection`: check `Applications in terminal may access keyboard`
- install oh-my-zsh
  - `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  - potential nice theme
    - `curl -sL https://raw.githubusercontent.com/moarram/headline/main/headline.zsh-theme -o ~/.oh-my-zsh/themes/headline.zsh-theme
  ZSH_THEME="headline"`
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

Install all Brew Cask applications and start each of them for the first time:
```bash
brew install --cask google-chrome firefox \
    rectangle flycut flameshot \
    visual-studio-code pycharm-ce docker \
    thunderbird obsidian vlc gimp zoom libreoffice \
    tailscale
```

- Rectangle: start app and set up permissions, set shortcuts for left/right half, next/previous display and fullscreen, launch on login
- Chrome
  - make default browser, disable form autofill and password management, install `uBlock Origin` and `1Password`
  - `Settings > Privacy and security > Security > Scroll to bottom`: toggle “Always use secure connections”
  - in Mac `Preferences > Keyboard > App Shortcuts`, set `Select Previous Tab` to `CMD-UP` `Select Next Tab` to `CMD-DOWN`, `Move Tab to New Window` to `CMD-D`
  - start a meeting on Google Meet and try to get audio, video and share screen, which will trigger permissions request and require restarting the app
- Flycut: start app and set up permissions, set shortcut to CMD + SHIFT + K, launch on login (https://github.com/TermiT/Flycut/issues/206), check `Move pasted item to top of stack`, `Security and Privacy > Privacy > Accessibility` add Flycut
- Flameshot: start app and try to make a screenshot to trigger permissions request
- Thunderbird: set up email accounts
  - Gmail: `imap.gmail.com:993`, `smtp.gmail.com:993` with email address as user name and application password as password
  - in account settings in `Copies & Folders`, check `Bcc these email addresses` with the email address of the account so all sent messages go to the inbox
- Zoom
  - start app and try to get audio, video and share screen, which will trigger permissions request and require restarting the app
  - disable audio and video when starting a meeting
- PyCharm: start app and set it up
- GIMP: start app as it takes longer the first time

VS Code:
- `Security & Privacy > Privacy > Full Disk Access` > add VS Code
- import profile from `pwalch.code-profile` in the repo

Notes about profile:
- `"key": "cmd+[Backslash]"` is actually '#', not backslash
- various points of interest
  - `workbench.action.previousEditor`
  - `workbench.action.nextEditor`
  - `viewContainer.workbench.view.explorer.enabled`
  - `explorer.openAndPassFocus`
  - `workbench.action.splitEditorRight`

### Terminal applications

```bash
brew tap pwalch/lonesnake
brew install \
    micro bat sd the_silver_searcher ripgrep up \
    fd exa tree broot ranger highlight fzf zoxide \
    direnv git-lfs diff-so-fancy lazygit gitui shellcheck mosh \
    nvm lonesnake \
    coreutils procs dust ctop lazydocker viddy \
    wget cowsay ffmpeg ipmitool docker-credential-helper-ecr
```

`micro ~/.config/micro/settings.json`

```json
{
    "tabstospaces": true
}
```

`micro ~/.config/micro/keybindings.json` (Ctrl-d solves the issue with backspace duplicating the line)
```json
{
    "Alt-/": "lua:comment.comment",
    "CtrlUnderscore": "lua:comment.comment",
    "Ctrl-d": "Delete",
}
```

`micro ~/.config/ranger/rc.conf`
```
copymap <UP>       k
copymap <DOWN>     l
copymap <LEFT>     j
copymap <RIGHT>    é
```

Node
- `nvm install 18`

Python
- `cd ~`
- `lonesnake`
- close and re-open terminal
- check that `which python` points to `~/.lonesnake/venv/bin` (this should be done by zshrc_custom)
- `pip install pipx`
- `for PACKAGE in thefuck httpie magic-wormhole black isort flake8; do pipx install "$PACKAGE"; done`

AWS
- install AWSCLI with [tutorial](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- `aws configure` and enter default keys
- `mkdir -p ~/.docker && echo '{"credsStore": "ecr-login"}' > ~/.docker/config.json`
- workaround for [Docker for Mac issue](https://github.com/docker/for-mac/issues/6295)
  - `alias docker-configure-ecr="mkdir -p ~/.docker && echo '{\"credsStore\": \"ecr-login\"}' > ~/.docker/config.json"`

### Kinesis Keyboard config

- enter Power User Mode: `PROGM + SHIFT + ESC`
- enable/disable virtual drive: `PROGM + F1`

`state.txt`
```
startup_file=p_qwerty.txt
key_click_tone=ON
toggle_tone=ON
macro_disable=OFF
macro_speed=3
status_play_speed=3
power_user=true

v_drive_open_on_startup=off
```

`p_qwerty.txt`
```
{=}>{speed8}{-lshift}{=}{+lshift}{space}
{lshift}{=}>{speed8}{=}{space}
{caps}>{speed8}{-lctrl}{z}{+lctrl}
[lctrl]>[rctrl]
[lalt]>[lalt]
[ralt]>[rctrl]
[rctrl]>[lalt]
[delete]>[lwin]
[end]>[delete]
{home}>{speed8}{-lshift}{2}{+lshift}
```

Tips
- on virtual keyboard, rctrl points to left CTRL key
- in Kinesis config file, rctrl corresponds to the expected CTRL-RIGHT key
- LeftOpt and RightOpt lead to the same key in virtual keyboard
- known correspondances between physical keyboard and Kinesis key names
  - STRG LEFT => `lctrl`
  - ALT LEFT => `lalt`
  - ALT GR => `ralt`
  - STRG RIGHT => `rctrl`

optional paging replacement
```
{pup}>{speed8}{up}{up}{up}{up}{up}{up}{up}{up}{up}{up}
{pdown}>{speed8}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}
```
