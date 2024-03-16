# dotfiles Command Line Utilities

## Modern CLI Utilities

cli:
	sudo apt update
	sudo apt install zsh duf fzf ripgrep fd-find htop most zoxide

## Configure neovim with [lazyvim](https://www.lazyvim.org/installation).
lazy:
	mv ~/.config/nvim{,.bak}
	mv ~/.local/share/nvim{,.bak}
	mv ~/.local/state/nvim{,.bak}
	mv ~/.cache/nvim{,.bak}
	git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git

## [Building neovim](https://github.com/neovim/neovim/blob/master/BUILD.md)
nvim:
	sudo apt update
	sudo apt install ninja-build gettext cmake unzip curl build-essential git
	git clone https://github.com/neovim/neovim
	cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=~/.local/
	sudo make install

## zsh
# Read [Configuring Zsh without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/).
zsh:
	cat /etc/shells
	sudo chsh -s $(which zsh) $USER

## pyenv and cpython build
pyenv:
	sudo apt update
	sudo apt install build-essential build-dep python3 gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.config/zsh/.zshrc
	echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.config/zsh/.zshrc
	echo 'eval "$(pyenv init -)"' >> ~/.config/zsh/.zshrc

## virtualenv plugin for pyenv
virtualenv:
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
	echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.config/zsh/.zshrc
