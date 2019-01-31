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

echo_color() {
  message=$1
  color=${2:-$color_normal}
  printf "$color$message $color_normal\n"
}

echo_title() {
  message="***** $1 *****\n"
  color=${2:-$color_green}
  echo_color "$message" "$color"
}

choice=(Python on
  Go on
  Java on
  Google-chrome on
  iTerm2 on
  SublimeText3 on
  Slack on
  Atom on
  Docker on
  Kubernetes on
  Shadowsocks off
  Wechat off
  Office on
  Intellij on
  )

usage=$"
Usage: Usage: install [options...]
Options:
--insecure
"

proxy_user=""
proxy=""
insecure=""
curlrc=~/.curlrc
curlrc_bak=~/.curlrcbak
export HOMEBREW_NO_AUTO_UPDATE=1 # ignore update or use `brew update`

while [ $# -gt 0 ]; do
  case $1 in
    --insecure)
    insecure="insecure"
    shift
    ;;
    *)
    echo_color "Invaid $1 $usage"
    exit 1;;
  esac
  shift || true
done


if [[ ! -z $insecure ]]; then
  #statements
  export HOMEBREW_CURLRC=1
  git config --global http.sslVerify false
  [ -e $curlrc ] && cp -f $curlrc $curlrc_bak
  cat <<-EOF > $curlrc
$proxy_user
$proxy
$insecure
EOF
fi

############ BREW ############
echo_title "BEGIN INSTALLING BREW"
which -s brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo_title "END INSTALLING BREW"
############ BREW ############

############ BREW CASK ############
echo_title "BEGIN INSTALLING BREW CASK"
brew tap caskroom/cask
echo_title "END INSTALLING BREW CASK"
############ BREW CASK ############

############ Basic ############
which -s tree || brew install tree
which -s wget || brew install wget

############ SOFTWARE ############
echo "Installing list: ${choice[*]}"
if ([[ ${choice[*]} == *"Python on"* ]]); then
  which -s python || brew install python
fi
if ([[ ${choice[*]} == *"Go on"* ]]); then
  which -s go || brew install golang
fi
if ([[ ${choice[*]} == *"Java on"* ]]); then
  brew cask install java
fi
if ([[ ${choice[*]} == *"Google-chrome on"* ]]); then
  brew cask install google-chrome
fi
if ([[ ${choice[*]} == *"iTerm2 on"* ]]); then
  brew cask install iterm2
fi
if ([[ ${choice[*]} == *"SublimeText3 on"* ]]); then
  brew cask install sublime-text
fi
if ([[ ${choice[*]} == *"Slack on"* ]]); then
  brew cask install slack
fi
if ([[ ${choice[*]} == *"Atom on"* ]]); then
  brew cask install atom
fi
if ([[ ${choice[*]} == *"Docker on"* ]]); then
  brew cask install docker
fi
if ([[ ${choice[*]} == *"Intellij on"* ]]); then
  brew cask install intellij-idea
fi
if ([[ ${choice[*]} == *"Kubernetes on"* ]]); then
  brew cask install minikube
  brew install kubernetes-cli
fi
if ([[ ${choice[*]} == *"Shadowsocks on"* ]]); then
  brew install shadowsocks-libev
fi
if ([[ ${choice[*]} == *"Wechat on"* ]]); then
  brew cask install wechat
fi
if [[ ${choice[*]} == *"Office on"* ]]; then
  brew cask install microsoft-office
fi

brew cleanup

[ -e $curlrc_bak ] && cp -f $curlrc_bak $curlrc


function startDocker {
  return
}

function startK8SLocal {
  minikube start
}

function testK8SLocal {
  kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
}


