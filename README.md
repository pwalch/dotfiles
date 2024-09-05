# dotfiles

Here are instructions to reproduce my development environment on macOS, along with all my dotfiles.

Check out the companion blog post: [Your dev environment is your ideal supermarket](https://pwal.ch/posts/2021-12-27-dev-env-dotfiles/).

## Installation instructions for Mac

### Foundation

After the first boot, perform all the possible OS updates:
- install major and minor upgrades in `System Settings > Software Updates`, then reboot and check again until there are no more updates
- in terminal, install XCode command line tools: `xcode-select --install`
- check again `System Settings > Software Updates` and install updates if available, then reboot again. Repeat until there are no more updates.
- `System Settings > Privacy & Security > FileVault`: click `Turn On FileVault` then set a recovery key and save it in password manager, then reboot
- Log into Apple ID account in AppStore

Create important directories:
- `mkdir ~/workspace`
- `mkdir -p ~/.local/bin`

Configure Mac settings:
- `Appearance`: set `Show scroll bars` to `Always`
- `Lock Screen > Turn display off on ...`: turn display off after 20 min on battery, after 1h for power adapter
- `Trackpad > Scroll & Zoom` > disable `Natural Scrolling`
- `Mouse` > disable `Natural Scrolling`
- Add printer

Keyboard
- `Keyboard > Text Input > Edit...` then disable "Use smart quotes and dashes"
- `Keyboard`: set `Key Repeat` to fastest and `Delay until Repeat` to shortest
- `Keyboard` > `Keyboard Shortcuts`
  - `Mission Control` > disable `Mission Control`
  - `Mission Control` > disable `Show Desktop` (F11)
  - `Display` > disable decrease and increase (F14 and F15)
  - `Input Sources`: uncheck `Select the previous ...` and `Select the next ...`
  - `Keyboard` > `Move focus to active or next window`: press `CMD + <`
  - `Keyboard` > disable "Turn keyboard access on or off" + "Move focus to the menu bar" + "Move focus to the Dock" + "Move focus to the window toolbar" + "Move focus to the floating window" + "Move focus to status menus" + "Change the way Tab moves focus" (F1-2-3, F5-6-7-8)
  - `Spotlight`: disable `Show Spotlight search` and `Show Finder search window`
- `Accessibility > Pointer Control > Mouse Options`: set to 3rd cursor from the right
- `Mouse > Tracking speed`: set to 3rd cursor from the right (this needs a mouse to be plugged in)

Desktop and dock
- `Desktop & Dock`: set a small size, set `Position on screen` to `right` and set `Automatically hide and show the Dock`
- remove all optional icons from Dock
- `Desktop & Dock > Shortcuts`: deactivate `ALT-DOWN` (Mission Control) and `ALT-UP` (Application windows) by replacing them with `-`
- `Control Center > Battery`: Show Percentage

Screen captures
- `mkdir ~/workspace/screen-recordings ~/workspace/screen-recordings`
- `Screenshot` app: go to `Options > Save to > Other location` > set to `~/workspace/screenshots`
- `Quicktime > New Screen Recording > Options > Other location` > set to `~/workspace/screen-recordings`

Finder
- `Finder` app: go to `Settings > Advanced` and check `Show all filename extensions`
- `Finder > General > New Finder windows show` set to `~/workspace`
- `Finder > Sidebar > Disable` disable Recents + Desktop + Documents + Downloads + iCloud Drive + CDs/DVDs + Cloud Storage + Bonjour computers + Connected servers
- `Finder > Advanced > When performing a search` set `Search the Current Folder`
- `Finder`: Add `~/workspace` and `~` to favorites (in the left menu bar)

### Terminal

Install Brew:
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- `echo '# If chezmoi not yet applied, register Brew\nif [[ ! -f "$HOME/.zshrc_custom.zsh" ]]; then\n  eval "$(/opt/homebrew/bin/brew shellenv)";\nfi' > ~/.zshenv`

Terminal configuration
- generate SSH key
- `brew install zsh-completions`
  - `ssh-keygen -t ed25519 -C "$(date "+%Y%m%d")-DEVICE-NAME"`
- install oh-my-zsh and some of its extensions

```bash
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh extensions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
```

Install Wezterm:
- `brew install --cask wezterm`
- install Wezterm terminal integration
  - `curl -sL -o ~/.wezterm_integration.sh https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh`
- close Terminal app and open Wezterm app
- `System Settings > Privacy & Security > Privacy > Full Disk Access`: add `Wezterm` from `Applications` directory

### Terminal applications

Install Brew terminal applications
- `https://raw.githubusercontent.com/pwalch/dotfiles/main/brew_install.sh | bash`

Python
- `cd ~`
- `lonesnake --py 3.11` (thefuck doesn't work with 3.12)
- `~/.lonesnake/venv/bin/pip install pipx`
- `for PACKAGE in itomate thefuck httpie magic-wormhole black isort flake8; do ~/.lonesnake/venv/bin/pipx install "$PACKAGE"; done`

AWS
- `aws configure` and enter default keys
- `mkdir -p ~/.docker && echo '{"credsStore": "ecr-login"}' > ~/.docker/config.json`
- workaround for [Docker for Mac issue](https://github.com/docker/for-mac/issues/6295)
  - `alias docker-configure-ecr="mkdir -p ~/.docker && echo '{\"credsStore\": \"ecr-login\"}' > ~/.docker/config.json"`

Apply chezmoi
- apply `chezmoi`
  - `sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply pwalch`

### GUI applications

Install all Brew Cask applications, then start all of them for the first time:
- `https://raw.githubusercontent.com/pwalch/dotfiles/main/brew_cask_install.sh | bash`

- Ukulele:
  - mkdir `~/.keyboard-layouts`
  - File > Install > Show Organizer > Set Folder and select `~/.keyboard-layouts`
  - File > New From Current Input Source, then right-click on "Swiss French" and click "Set Keyboard Name and Script" and set name to `Swiss French pwalch`,
  - double-click on `Swiss French pwalch`, then press OPT on physical keyboard and double click on "~" key square, go to "Terminator" tab and put the empty string, then to Make Output and put the "~" character (including the space to complete its constructions)
  - File > Save, select File Format "Keyboard Layout Bundle" and save as `~/.keyboard-layouts/swiss-french-pwalch.bundle`
  - drag'n'drop `swiss-french-pwalch` from Not Installed column to "Installed for All Users" column, then enter password and proceed
  - you will be asked to reboot, press ok, then reboot
  - System Settings > Keyboard > Text Input > Input Sources > Edit > Press Plus, in "French", select `Swiss French pwalch`
  - on the top-right of the screen, select keyboard layout `Swiss French pwalch`
  - tilde should now type directly, without needing a space

- Rectangle: start app and set up permissions, set shortcuts for left/right half, next/previous display and fullscreen, launch on login, hide menu bar icon
- Flycut: start app and set up permissions, set shortcut to CMD + SHIFT + K, check `Move pasted item to top of stack`, `Privacy & Security > Privacy > Accessibility` add Flycut, launch on login by going to "Login Items" and adding "Flycut.app" (https://github.com/TermiT/Flycut/issues/206)
- noTunes
  - start noTunes app and accept to open
  - `System Preferences > Login Items` in `Open at Login` add noTunes
- GIMP: start app as it takes longer the first time

Chrome
- make default browser, disable form autofill and password management, install `uBlock Origin` and `1Password`
- `Settings > Privacy and security > Security > Scroll to bottom`: toggle `Always use secure connections`
- in `Settings > Keyboard > App Shortcuts`, set `Select Previous Tab` to `CMD-UP` `Select Next Tab` to `CMD-DOWN`, `Move Tab to New Window` to `CMD-D`
- start a meeting on Google Meet and try to get audio, video and share screen, which will trigger permissions request and require restarting the app

Firefox
- make default browser, disable password autofill, install `uBlock Origin` extension
- `Privacy & Security > Passwords`uncheck `Ask to save passwords`
- `Privacy & Security HTTPS-Only Mode` select `Enable HTTPS-Only mode in all windows`
- log in

Thunderbird: set up email accounts
- Gmail: `imap.gmail.com:993`, `smtp.gmail.com:993` with email address as user name and application password as password
- in account settings in `Copies & Folders`, check `Bcc these email addresses` with the email address of the account so all sent messages go to the inbox

Zoom
- log in, start a meeting and try to get audio, video and share screen, which will trigger permissions request and require restarting the app
- in `Background & Effects` and enable virtual background
- in `Audio` check `Automatically join computer audio when joining` and `Mute my mic when joining`
- in `Video` check `Stop my video when joining`
- in `PMI Settings` (appears when clicking on down-arrow next to `New Meeting` button), check `Waiting Room` and `Mute participants upon entry`
- disable audio and video when starting a meeting

Raycast
- use `CMD-SPACE` as Raycast shortcut
- `mkdir ~/.local/bin/raycast`
- Extensions > Script Commands > Add Directories: add `~/.local/bin/raycast`

VS Code:
- in macOS System Settings, go to `Privacy & Security > Privacy > Full Disk Access` then add `VS Code`
- `Settings > Profile` then `Import Profile...`
- import profile from `pwalch.code-profile` in the repo

Notes about VS Code profile:
- `"key": "cmd+[Backslash]"` is actually '#', not backslash
- various points of interest
  - `workbench.action.previousEditor`
  - `workbench.action.nextEditor`
  - `viewContainer.workbench.view.explorer.enabled`
  - `explorer.openAndPassFocus`
  - `workbench.action.splitEditorRight`

### Kinesis Keyboard config

- enter Power User Mode: `PROGM + SHIFT + ESC`
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
{lshift}{=}>{speed8}{=}
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
