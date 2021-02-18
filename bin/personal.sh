#!/bin/bash

personal_packages=(
  'ohmyzsh'
  'zshplugins'
  'spotify'
  'brave'
	'onedrive'
	'dracula'
	'virtmanager'
	'calibre'
  )

install_personal(){
	for package in "${personal_packages[@]}"
	do
		if ! hash $package 2>/dev/null; then
			install_$package
		else
			fail "${$package} is already installed!"
		fi
	done

	user "Download jonaselan's dotfiles? (y/n)"
	read choice;

	if [[ $choice == "y" ]]; then
		update_dotfiles
	fi
}

install_spotify(){
	user "Installing Spotify"
	user "Based on: https://www.spotify.com/br/download/linux/"

	# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	# 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	# 3. Update list of available packages
	sudo apt-get update
	# 4. Install Spotify
	sudo apt-get install spotify-client -y

	success "Spotify installed"
}

install_ohmyzsh(){
	if [[ -e /usr/bin/zsh && -e ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
		fail "Oh-My-Zsh is already installed!"
	else
		info "Installing Oh-My-Zsh"
		info "Based on: https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md"

		if [[ ! -e /usr/bin/zsh ]]; then
			user "Zsh is required. Do you want install it? (y/n)"
			read choice;

			if [[ $choice == "y" ]]; then
				sudo apt update && sudo apt install zsh
				chsh -s $(which zsh)
				zsh --version
			fi
		fi

		if [[ -e /usr/bin/curl ]]; then
			cd
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
			cd -
		else
			if [[ -e /usr/bin/wget ]]; then
				cd
				sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
				cd -
			else
				user "curl or wget is required. Do you want install them? (y/n)"
				read choice;

				if [[ $choice == "y" ]]; then
					sudo apt update && sudo apt install wget curl
					smpc $_action $_option
				fi
			fi
		fi

		success "Oh-My-Zsh Installed"
	fi
}

# I know the exist plugin managers, but this way I don't install extra things
install_zshplugins(){

	info "Installing Spaceship theme"
	info "https://github.com/denysdovhan/spaceship-prompt#oh-my-zsh"

	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	success "spaceship-theme Installed"
	# ------------
		info "Installing Zinit"
	info "Based on: https://github.com/zdharma/zinit#option-1---automatic-installation-recommended"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
	
	success "Zinit Installed"
}


install_dracula(){
  info "Installing Sublime Text..."

	git clone https://github.com/dracula/gnome-terminal
	cd gnome-terminal

	./install.sh

	cd

	success "Dracula Theme installed"
}


install_onedrive(){
  info "Installing Onedrive..."
	user "Based on: https://github.com/abraunegg/onedrive/blob/master/docs/INSTALL.md"

	sudo add-apt-repository ppa:yann1ck/onedrive -y

	sudo apt update

	sudo apt install onedrive

	onedrive --synchronize --verbose

	systemctl enable onedrive@$(whoami).service
	systemctl start onedrive@$(whoami).service

	success "Onedrive installed"
}

install_brave(){
  info "Installing Brave Browser..."
	
	user "Based on: https://brave.com/linux/"


	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update

	sudo apt install brave-browser

	success "Brave Browser installed"
}

install_virtmanager(){
	info "Installing Virt-Manager..."
	user Based on: "https://www.tecmint.com/install-kvm-on-ubuntu/"

	sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager
	sudo systemctl enable --now libvirtd

success "Virt-Manager installed"
}

install_calibre(){
	info "Installing Calibre..."
	user "Based on: https://calibre-ebook.com/pt_BR/download_linux"

	sudo -v 

	wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
	success "Calibre installed"
}