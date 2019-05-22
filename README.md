# setup-my-pc
Easy installation of things on the fresh pc (or not)

## Notes
- **Setup my pc** is a _Command Line Tool_ that makes easier to set up and to install some softwares.
- Limit to my tools the I use every day (feel free to fork and adapt to your interests)
- Tested only on distribution based on Ubuntu

## Installing

```bash
$ git clone https://github.com/jonaselan/setup-my-pc.git
$ cd setup-my-pc
$ source install.sh
```

## Usage

With a fresh pc, I recommend follow this steps:

```bash
# step 1
$ smpc basic
# step 2
$ smpc personal
# step 3
$ smpc dev
```

## Available options
	basic: install all basic tools
	personal: install all personal tools
	dev: install all development tools

## Basic

- vim
- wget
- curl
- java
- node

### Personal

- ohmyzsh
- terminator
- bat
- ripgrep
- kolourpaint4
- spotify
- vlc

### Dev

- php
- Docker
- Docker-compose
- composer
- dbeaver
- postman
- htop

Project inspired on [MEOU](https://github.com/DavidCardoso/my-env-on-ubuntu)