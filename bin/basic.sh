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
  $(command_exists gnome-calendar || echo gnome-calendar)
  $(command_exists gnome-contacts || echo gnome-contacts)
  $(command_exists gnome-weather || echo gnome-weather)
  $(command_exists firefox || echo firefox)
  $(command_exists seahorse || echo seahorse)
  $(command_exists geary || echo geary)
  $(command_exists gedit || echo gedit)

)

install_basic() {
  update_packages

  if [[ ${#basic_packages_install[@]} != 0 ]]; then
    sudo apt-get install ${basic_packages_install[@]} -y
  fi

  if [[ ${#packages_remove[@]} != 0 ]]; then
    sudo apt-get remove ${packages_remove[@]} -y
  fi

  success "Basic tools installed"
}
