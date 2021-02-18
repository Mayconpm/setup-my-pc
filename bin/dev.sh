#!/bin/bash

dev_packages=(
	'miniconda'
	'vscode'
	'sublimetext'
	# 'docker'
	# 'docker-compose'
)

faculdade_packages=(
	$(command_exists scilab || echo scilab)
	$(command_exists wxmaxima || echo wxmaxima)
)

install_dev() {
	update_packages

	for package in "${dev_packages[@]}"; do
		if ! hash $package 2>/dev/null; then
			install_$package
		else
			fail "${package} already installed"
		fi
	done

	if [[ ${#faculdade_packages[@]} != 0 ]]; then
		sudo apt-get install ${faculdade_packages[@]} -y
	fi

}

install_docker() {
	info "Installing Docker CE..."
	info "Based on: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/"

	sudo apt remove docker docker-engine docker.io
	sudo apt update
	sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
	curl -sSL https://get.docker.com/ | sh
	warning "Adding '$(whoami)' user to the docker group..."
	sudo usermod -aG docker $(whoami)

	success "Docker CE installed"
}

install_docker-compose() {
	info "Installing Docker Compose..."
	info "Based on: https://docs.docker.com/compose/install/#install-compose"

	sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version

	success "Docker Compose installed."
}

install_miniconda() {

	info "Installing Miniconda..."
	mkdir -p ~/miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
	rm -rf ~/miniconda3/miniconda.sh
	~/miniconda3/bin/conda init bash
	~/miniconda3/bin/conda init zsh

	conda create --name projects --file $HOME/.smpc/spec-file.txt -y

	success "Miniconda installed"
}

install_sublimetext() {
	info "Installing Sublime Text..."

	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	subl
	sudo apt-get update
	sudo apt-get install sublime-text

	success "Sublime Text installed"
}

install_vscode() {
	info "Installing Visual Studio Code..."
	info "Based on: https://sempreupdate.com.br/como-instalar-o-visual-studio-code-no-ubuntu-20-04/"

	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add --

	sudo add-apt-repository “deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main”

	sudo apt update

	sudo apt install code

	success "Visual Studio Code installed"
}
