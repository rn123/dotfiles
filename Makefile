# dotfiles Command Line Utilities

## Modern CLI Utilities
cli:
	sudo apt update
	sudo apt install -y zsh duf fzf ripgrep fd-find htop most zoxide strace lsof iproute2 tree
	mkdir -p ~/.local/bin && ln -sf $$(command -v fdfind) ~/.local/bin/fd

## Read [Building neovim](https://github.com/neovim/neovim/blob/master/BUILD.md)
nvim:
	sudo apt update
	sudo apt install -y ninja-build gettext cmake unzip curl build-essential git
	git clone https://github.com/neovim/neovim ~/scratch/neovim
	cd ~/scratch/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo # CMAKE_INSTALL_PREFIX=~/.local/
	cd ~/scratch/neovim && sudo make install

## Configure neovim with [lazyvim](https://www.lazyvim.org/installation).
lazy:
	rm -rf ~/.config/nvim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git

## Read [Configuring Zsh without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/).
## Links ~/dotfiles to this checkout when it lives elsewhere.
zshconfig:
	@case "$(CURDIR)" in /mnt/*) \
		echo "Windows-mounted files are world-writable, which makes compinit stop at an"; \
		echo "'insecure directories' prompt. Clone into the WSL home and run make there:"; \
		echo "  git clone https://github.com/rn123/dotfiles.git ~/dotfiles"; \
		exit 1;; \
	esac
	[ -e ~/dotfiles ] || ln -s $(CURDIR) ~/dotfiles
	cp zshenv ~/.zshenv
	mkdir -p ~/.config && cp -r zsh ~/.config
	chmod -R go-w ~/.zshenv ~/.config/zsh

## Make zsh the login shell
chsh:
	chsh -s $$(command -v zsh)

## WSL: stop appending the Windows PATH (then run `wsl --shutdown` from Windows)
wsl:
	@if grep -q '^appendWindowsPath' /etc/wsl.conf 2>/dev/null; then \
		echo "appendWindowsPath already set in /etc/wsl.conf"; \
	elif grep -q '^\[interop\]' /etc/wsl.conf 2>/dev/null; then \
		echo "add appendWindowsPath=false under [interop] in /etc/wsl.conf"; \
	else \
		printf '\n[interop]\nappendWindowsPath=false\n' | sudo tee -a /etc/wsl.conf; \
	fi

## pyenv and cpython build
pyenv:
	sudo apt update
	sudo apt install -y build-essential python3 gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses-dev libreadline-dev libsqlite3-dev libssl-dev \
      tk-dev uuid-dev zlib1g-dev
	[ -d ~/.pyenv ] || git clone https://github.com/pyenv/pyenv.git ~/.pyenv

## virtualenv plugin for pyenv
virtualenv:
	[ -d ~/.pyenv/plugins/pyenv-virtualenv ] || git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')

