source $VIMRUNTIME/defaults.vim
let g:netrw_liststyle=3
set shell=zsh

set ts=2 sw=2 expandtab
" Cursor in terminal
  " https://vim.fandom.com/wiki/Configuring_the_cursor
  " 1 or 0 -> blinking block
  " 2 solid block
  " 3 -> blinking underscore
  " 4 solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
set timeoutlen=1000
set ttimeoutlen=5

if &term =~ '^xterm'
  " insert mode
  let &t_SI .= "\e[5 q"
  " normal mode
  let &t_EI .= "\e[1 q"

  let &t_ti .= "\e[1 q"
  let &t_te .= "\e[0 q"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

set laststatus=2
map ; :Files<CR>
map <C-p> :NERDTreeToggle<CR>
nnoremap <C-g> :YcmCompleter GoTo<CR>
nnoremap <C-s> :YcmCompleter Format<CR>
" Automatic install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:prettier#exec_cmd_async = 1

call plug#begin("~/.vim/plugged")
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdtree'
Plug 'kevinoid/vim-jsonc'
Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install && yarn add prettier-plugin-solidity',
  \ 'branch': 'release/1.x' }
Plug 'ycm-core/YouCompleteMe'
Plug 'tomlion/vim-solidity'
call plug#end()
