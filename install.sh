#!/bin/bash

# Define colors
color_normal="\x1B[0m"
color_red="\x1B[31m"
color_green="\x1B[32m"
color_yellow="\x1B[33m"
color_blue="\x1B[34m"
color_magenta="\x1B[35m"
color_cyan="\x1B[36m"
color_white="\x1B[37m"

# Echo a message in color (default to normal color)
# usage: echo_color message
# usage: echo_color message $color_red
echo_color() {
  message=$1
  color=${2:-$color_normal}
  printf "$color$message $color_normal\n"
}

# Echo a title in color 
# usage: echo_title message
# usage: echo_title message color
echo_title() {
  message="***** $1 *****\n"
  color=${2:-$color_green}
  echo_color "$message" "$color"
}

clear

############ BREW ############
echo_title "BEGIN INSTALLING BREW"
which -s brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew update
echo_title "END INSTALLING BREW"
############ BREW ############


############ BREW CASK ############
echo_title "BEGIN INSTALLING BREW CASK"
brew tap caskroom/cask
echo_title "END INSTALLING BREW CASK"
############ BREW CASK ############

choice=(python on
  go on
  java on
  git on
  google-chrome on
  iTerm2 on
  SublimeText3 on
  Slack on
  Aton on
  Docker on
  Kubernetes on
  Shadowsocks off
  )


############ Basic ############
which -s tree || brew install tree
which -s wget || brew install wget

############ SOFTWARE ############
echo_color ${choice[*]}
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"python on"* ]]); then
  which -s python || brew install python
fi
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"go on"* ]]); then
  which -s go || brew install golang
fi
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"java on"* ]]); then
  brew install cask java
fi
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"git on"* ]]); then
  which -s git || brew install git
fi
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"google-chrome on"* ]]); then
  brew install cask google-chrome
fi
if ([[ $choice == *"all"* ]] || [[ ${choice[*]} == *"iTerm2 on"* ]]); then
  brew install cask iterm2
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"SublimeText3 on"* ]]); then
  brew cask install sublime-text
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Slack on"* ]]); then
  brew cask install slack
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Atom on"* ]]); then
  brew cask install atom
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Docker on"* ]]); then
  brew cask install docker
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Intellij on"* ]]); then
  brew cask install intellij-idea
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Kubernetes on"* ]]); then
  brew cask install minikube
  brew install kubernetes-cli
fi
if ([[ $choice == *"all"* ]] || [[ $choice == *"Shadowsocks on"* ]]); then
  brew install shadowsocks-libev
fi

brew cleanup



