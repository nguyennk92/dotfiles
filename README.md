# Clone to others
```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
git clone --bare https://www.github.com/nguyennk92/dotfiles.git $HOME/.dotfiles/
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
