.PHONY: install zsh tmux stow python node cargo rclone bat 
UNAME := $(shell uname)

all: install zsh tmux stow python node cargo rclone bat

stow:
	stow -R -v git bash zsh i3 joshuto kitty npm skhd tmux vim vscode yabai dev rclone ic cheat

install:
	@sort --output=pkglist pkglist
	@if [ "$(UNAME)" = "Linux" ]; then \
	    if [ -x "$$(command -v apt)" ]; then \
			sudo apt update; \
			for i in $$(cat pkglist); do sudo apt-get install -y $$i; done; \
	    elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman -Syu; \
			sudo pacman -S --needed --noconfirm - < pkglist; \
	    else \
		echo "No supported package manager found"; \
	    fi \
	elif [ "$(UNAME)" = "Darwin" ]; then \
		for i in $$(cat pkglist); do brew install $$i; done; \
	else \
	    echo "Unsupported operating system"; \
	fi
	[-x "$$(command -v fdfind)" ] && ln -s $(which fdfind) ~/.local/bin/fd

zsh:
	@if [ ! -d "$${HOME}/.oh-my-zsh" ]; then \
		cd || exit; \
		[ -e "$${HOME}/install.sh" ] || wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh; \
		sh install.sh; \
	elif [ ! -d "$${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then \
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/themes/powerlevel10k; \
		git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions; \
		git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting; \
		git clone --depth=1 https://github.com/unixorn/fzf-zsh-plugin.git "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin; \
		git clone --depth=1 https://github.com/zsh-users/zsh-completions.git "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/plugins/zsh-completions; \
		git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git "$${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}"/plugins/zsh-vi-mode; \
		[ -e $${HOME}/install.sh ] && rm $${HOME}/install.sh; \
	fi

tmux:
	@if [ ! -d $${HOME}/.tmux ]; then \
		cd || exit; \
		git clone https://github.com/gpakosz/.tmux.git; \
		ln -s -f .tmux/.tmux.conf . ;\
		ln -s -f dotfiles/tmux.conf.local ./.tmux.conf.local; \
	fi

python:
	@[ -x "$$(command -v python3)" ] || sudo apt install python3
	@sort --output=piplist piplist
	@for i in $$(cat piplist); do python3 -m pip install $$i; done
	@[ -e "$${HOME}/.virtualenvs" ] || mkdir $$HOME/.virtualenvs
	@[ -e "$${HOME}/.virtualenvs/cocotbenv" ] || python3 -m venv $$HOME/.virtualenvs/cocotbenv

node:
	PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
	export NVM_DIR="$${HOME}/.nvm"
	[ -s "$${NVM_DIR}/nvm.sh" ] && . "$${NVM_DIR}/nvm.sh" && nvm install --lts
	for i in $$(cat npmlist); do sudo npm install -g $$i; done; # Bug, can't find npm

cargo:
	curl https://sh.rustup.rs -sSf | sh
	. "$$HOME/.cargo/env" && for i in $$(cat cargolist); do cargo install $$i; done; \

rclone:
	sudo -v ; curl https://rclone.org/install.sh | sudo bash

bat:
	mkdir -p ~/.local/bin
	[ -e $${HOME}/.local/bin/bat ] || ln -s /usr/bin/batcat ~/.local/bin/bat
	git clone --depth 1 https://github.com/eth-p/bat-extras.git /tmp/bat-extras
	cd /tmp/bat-extras && sudo ./build.sh --install

fzf:
	git clone https://github.com/junegunn/fzf-git.sh.git "$${HOME}/fzf-git.sh"
