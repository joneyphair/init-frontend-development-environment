#!/usr/bin/env bash


msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

exists() {
    command -v "$1" >/dev/null 2>&1
}

install_brew() {

 	if ! exists "brew"; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_brew_cask() {

 	if ! exists "brew cask"; then
		brew tap caskroom/cask
    fi
}

brew_install() {

	if ! exists "$1";then
		brew install "$1"
		ret="$?"
		success "已安装$1"
	fi

	success "本地已安装$1"

}

brew_cask_instal() {

	brew cask install $1
}

npm_install() {

	if  exists "npm" && !exists "$1";then
		npm install "$1"
		ret="$?"
		success "已安装$1"
	fi

}

npm_global_install() {

	if  exists "npm" && ! exists "$1";then
		npm install -g "$1"
		ret="$?"
		success "已安装$1"
	fi

}


init() {
	install_brew
	install_brew_cask
	ret="$?"
	success "初始化完成"
}

init


brew_install nginx
brew_install node
brew_install git
brew_install tig
brew_install vim

brew_cask_instal google-chrome
brew_cask_instal wewechat
brew_cask_instal  dingtalk-beta


npm_global_install yarn
npm_global_install cnpm 
npm_global_install anyproxy 
npm_global_install n 
npm_global_install nvm 
npm_global_install react-native-cli
npm_global_install vue-cli


