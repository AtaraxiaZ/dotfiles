.PHONY: stow install zsh tmux
UNAME := $(shell uname)

all: install zsh tmux stow python

stow:
	stow -R -v git bash zsh i3 joshuto kitty npm skhd tmux vim vscode yabai dev

install:
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
	else \
	    echo "Unsupported operating system"; \
	fi
	@[ -x "$$(command -v batcat)" ] || (mkdir -p $${HOME}/.local/bin && ln -s /usr/bin/batcat $${HOME}/.local/bin/bat)
	for i in $$(cat npmlist); do sudo npm install -g $$i; done; \
	for i in $$(cat cargolist); do cargo install $$i; done; \

zsh:
	@if [ ! -d "$${HOME}/.oh-my-zsh" ]; then \
		cd || exit; \
		[ -e "$${HOME}/install.sh" ] || wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh; \
		sh install.sh; \
	else \
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
