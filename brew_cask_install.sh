#!/usr/bin/env bash

set -euo pipefail

# Browsers
brew install --cask google-chrome firefox

# Keyboard
brew install --cask ukelele flycut raycast

# Compensations for bad OS patterns
brew install --cask notunes caffeine

# Coding
brew install --cask visual-studio-code orbstack balenaetcher

# Monitoring
brew install --cask sloth wireshark

# Productivity
brew install --cask thunderbird obsidian zoom chatgpt tailscale 1password

# Media
brew install --cask vlc gimp

echo "Finished installing all brew cask applications"
