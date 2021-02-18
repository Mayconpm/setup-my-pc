#!/bin/bash

basic_packages_install=(
  $(command_exists bcmwl-kernel-source || echo bcmwl-kernel-source)
  $(command_exists git || echo git)
  $(command_exists wget || echo wget)
  $(command_exists curl || echo curl)
  $(command_exists gnupg || echo gnupg)
  $(command_exists software-properties-common || echo software-properties-common)
  $(command_exists apt-transport-https || echo apt-transport-https)
  $(command_exists gnome-tweaks || echo gnome-tweaks)
  $(command_exists vlc || echo vlc)
  $(command_exists ubuntu-restricted-extras || echo ubuntu-restricted-extras)
  $(command_exists build-essential || echo build-essential)

)

packages_remove=(
  'gnome-calendar'
  'gnome-contacts'
  'gnome-weather'
  'firefox'
  'seahorse'
  'geary'
  'gedit'

)

install_basic() {
  update_packages

  if [[ ${#basic_packages_install[@]} != 0 ]]; then
    sudo apt-fast install ${basic_packages_install[@]} -y
  fi

  if [[ ${#packages_remove[@]} != 0 ]]; then
    sudo apt-fast remove ${packages_remove[@]} -y
  fi

  user "Download Maycon's dotfiles? (y/n)"
	read choice

	if [[ $choice == "y" ]]; then
		update_dotfiles
	fi

  success "Basic tools installed"
}
