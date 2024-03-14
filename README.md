# dotfiles
# Command Line

## Configure neovim with [lazyvim](https://www.lazyvim.org/installation).

```sh
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git
```

## [Building neovim](https://github.com/neovim/neovim/blob/master/BUILD.md)

```sh
sudo apt-get install ninja-build gettext cmake unzip curl build-essential git
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=~/.local/
sudo make install
```

## zsh

Read [Configuring Zsh without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/).

```sh
cat /etc/shells
sudo chsh -s $(which zsh) $USER
```


