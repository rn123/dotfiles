# dotfiles Command Line Utilities

Run `make` to list the targets. Everything targets Debian/Ubuntu (apt), including WSL.

## Quick start

```sh
git clone https://github.com/rn123/dotfiles.git ~/dotfiles
cd ~/dotfiles
make cli zshconfig chsh
```

## WSL on Windows

- Run `make` from inside WSL, not PowerShell, in a clone in the Linux home (`~/dotfiles`).
  Everything under `/mnt/c` is mode `0777`, so compinit stops at an "insecure directories" prompt,
  and git and ripgrep are much slower there. `make zshconfig` refuses to run from `/mnt/*`.
- `make wsl` sets `appendWindowsPath=false` in `/etc/wsl.conf` so zsh completion doesn't scan ~30
  Windows directories; then run `wsl --shutdown` from Windows. `zshenv` adds back
  `/mnt/c/windows/system32` and `/mnt/c/windows` (for `clip.exe`, `explorer.exe`).
- `clipboard` uses `clip.exe` when it's available, otherwise kitty.
- `.gitattributes` forces LF endings so a Windows-side checkout (`core.autocrlf=true`) can't break
  the shell scripts or the Makefile.

## Modern CLI Utilities

`make cli`:

```sh
sudo apt update
sudo apt install zsh duf fzf ripgrep fd-find htop most zoxide strace lsof iproute2 tree
ln -sf $(command -v fdfind) ~/.local/bin/fd   # Debian names the binary fdfind
```

## zsh

Read [Configuring Zsh without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/).
`make zshconfig` copies `zshenv` to `~/.zshenv` and `zsh/` to `~/.config/zsh`. `make chsh` makes zsh
the login shell.

`history` is the zsh builtin `fc` (fix command); see `man zshbuiltins`. The `hi` alias pipes it to fzf.

## neovim

`EDITOR`, `VISUAL` and `MANPAGER` all use `nvim`. The apt package is recent enough for LazyVim:

```sh
sudo apt install neovim
```

Or build it with `make nvim` ([Building neovim](https://github.com/neovim/neovim/blob/master/BUILD.md)).

### Configure neovim with [lazyvim](https://www.lazyvim.org/installation)

`make lazy` replaces `~/.config/nvim` with the LazyVim starter. Back up an existing config first:

```sh
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

## pyenv and cpython build

`make pyenv` installs the CPython build dependencies and clones pyenv to `~/.pyenv`;
`make virtualenv` adds the pyenv-virtualenv plugin. `.zshrc` initializes both when they're present.
