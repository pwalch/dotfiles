#!/usr/bin/env bash

set -euo pipefail

# Text management
brew install micro bat sd ripgrep up coreutils gnu-sed jless cowsay

# File management
brew install fd eza tree fzf p7zip

# Navigation and environment
brew install zoxide direnv yazi

# Monitoring
brew install procs dust ctop lazydocker viddy sniffnet

# Git
brew install git-lfs diff-so-fancy lazygit

# Lang-specific
brew tap pwalch/lonesnake && brew install lonesnake nvm shellcheck

# Servers
brew install awscli docker-credential-helper-ecr ipmitool mosh wget

# Media
brew install ffmpeg
