#!/bin/bash

basic_packages_install=(
  $(command_exists curl || echo bcmwl-kernel-source)
  $(command_exists git || echo git)
  $(command_exists wget || echo wget)
  $(command_exists curl || echo curl)
  $(command_exists curl || echo gnupg)
  $(command_exists curl || echo software-properties-common)
  $(command_exists curl || echo apt-transport-https)
  $(command_exists curl || echo autokey-gtk)
  $(command_exists curl || echo scilab)
  $(command_exists curl || echo wxmaxima)
  $(command_exists curl || echo gnome-tweaks)
  $(command_exists curl || echo vlc)
  $(command_exists curl || echo ubuntu-restricted-extras)
  $(command_exists curl || echo build-essential)
  $(command_exists curl || echo vlc)
  $(command_exists curl || echo vlc)
  $(command_exists curl || echo vlc)

)

basic_packages_remove=(
  $(command_exists curl || echo gnome-calendar)
  $(command_exists git || echo gnome-contacts)
  $(command_exists wget || echo gnome-weather)
  $(command_exists curl || echo firefox)
  $(command_exists curl || echo seahorse)
  $(command_exists curl || echo geary)
  $(command_exists curl || echo gedit)

)

install_basic() {
  update_packages

  if [[ ${#basic_packages_install[@]} != 0 ]]; then
    sudo apt-get install ${basic_packages_install[@]} -y
  fi

  if [[ ${#basic_packages_remove[@]} != 0 ]]; then
    sudo apt-get remove ${basic_packages_remove[@]} -y
  fi

  success "Basic tools installed"
}
