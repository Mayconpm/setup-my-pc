#!/bin/bash

update_dotfiles() {
	# clone dotifles
	git clone https://github.com/Mayconpm/dotfiles.git ~/.smpc

	# Setup folders
	mkdir ~/.config/onedrive/

	# src:dest
	link_files=(
		"$HOME/.smpc/.zshrc:$HOME/.zshrc"
		"$HOME/.smpc/.asoundrc:$HOME/.asoundrc"
		"$HOME/.smpc/.gitconfig:$HOME/.gitconfig"
		"$HOME/.smpc/onedrive:$HOME/.config/onedrive/sync_list"
		"$HOME/.smpc/daemon.conf:$HOME/.config/pulse/daemon.conf"
	)

	# Link files
	info 'Linking dotfiles'
	for lf in "${link_files[@]}"; do
		src="$(echo -n $lf | cut -d':' -f1)"
		dest="$(echo -n $lf | cut -d':' -f2)"

		ln -sTf - $src $dest

		# explicit simbolyc link
		stat -c '%N' "$(echo -n $lf | cut -d':' -f2)"
	done

	success 'Dotfiles updated'
}

info() {
	printf "\r  [ \033[00;34m...\033[0m ] $1\n"
}

warning() {
	printf "\r  [ \033[00;36m\!\!\033[0m ] $1\n"
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

command_exists() {
	# redirect the output of your program to "nothing"
	type "$1" >/dev/null 2>&1
}

show_help() {
	echo
	cat $SMPCPATH/help.txt
	echo
}

show_version() {
	cd $SMPCPATH && git fetch -vp 2 &>/dev/null
	git tag -l --sort=v:refname | egrep v. | tail -1
	cd - 2 &>/dev/null
}

confirm_install() {
	user "Do you want to install $1? (y/n)"
	read choice
	if [[ $choice == "Y" || $choice == "y" || $choice == "yes" ]]; then
		install_$1
	else
		info "...Not installed!"
	fi
}

update_packages() {
	sudo apt-get update && sudo apt-fast upgrade -y && sudo apt autoremove
}
