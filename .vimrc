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
map , :Files<CR>
map <C-p> :NERDTreeToggle<CR>
"nnoremap <leader>r :YcmForceCompileAndDiagnostics<CR>
"nnoremap <leader>f :YcmCompleter Format<CR>
"nnoremap <leader>g :YcmCompleter GoTo<CR>
"nnoremap <leader>2 :YcmCompleter GetDoc<CR>
"nnoremap <leader>1 :YcmCompleter FixIt<CR>

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" Automatic install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


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
"Plug 'ycm-core/YouCompleteMe'
Plug 'tomlion/vim-solidity'
Plug 'Valloric/ListToggle'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
call plug#end()

" ALE configuration
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \'go': ['gopls'],
      \}
let g:ale_fixers = {
      \'javascript': ['prettier', 'eslint'],
      \'go': ['goimports'],
      \}
nnoremap <leader>2 :ALEHover<CR>
nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>s :ALESymbolSearch<CR>

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
  \ '_': ['ale'],
  \})
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
