if !has('nvim')
  source $VIMRUNTIME/defaults.vim
endif
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
nnoremap , :Files<CR>
nnoremap <lt> :Rg<CR>
nnoremap <C-p> :NERDTreeToggle<CR>

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" Automatic install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1

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
Plug 'prabirshrestha/vim-lsp'
Plug 'Shougo/echodoc.vim'
call plug#end()

" ALE configuration
let g:ale_set_balloons = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \'go': ['gopls'],
      \'javascript': ['tsserver']}
let g:ale_fixers = {
      \'go': ['gofmt'],
      \'javascript': ['prettier']}
let g:ale_go_gopls_init_options = {'ui.diagnostic.analyses': {
      \ 'nilness': v:true,
      \ 'shadow': v:true,
      \ }}
let g:ale_go_gopls_options = ""
nnoremap <leader>1 :ALECodeAction<CR>
nnoremap <leader>2 :ALEHover<CR>
nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>r :ALEReset<CR>
nnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>s :ALESymbolSearch<CR>

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport = 1

inoremap <Nul> <C-x><C-o>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:echodoc#enable_at_startup = 1
if has('nvim')
  let g:echodoc#type = 'floating'
else
  let g:echodoc#type = 'popup'
endif
