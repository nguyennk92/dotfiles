if !has('nvim')
  source $VIMRUNTIME/defaults.vim
endif
let g:netrw_liststyle=3
set shell=zsh
set splitright

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
nnoremap ; :Rg<CR>
nnoremap <C-p> :NERDTreeToggle<CR>

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
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rhysd/vim-lsp-ale'
Plug 'Shougo/echodoc.vim'
call plug#end()

" LSP configurations for vim-lsp
if executable('gopls')
    autocmd User lsp_setup call lsp#register_server({
        \   'name': 'gopls',
        \   'cmd': ['gopls'],
        \   'allowlist': ['go', 'gomod'],
        \ })
endif
if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \   'name': 'tsserver',
        \   'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \   'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact','typescript', 'typescript.jsx', 'typescriptreact'],
        \ })
endif

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_fold_enabled = 0
let g:lsp_semantic_enabled = 0
let g:lsp_text_edit_enabled = 0
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
imap <Nul> <Plug>(asyncomplete_force_refresh)

" ALE configuration
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \'_': ['vim-lsp'],
      \'solidity': ['solc', 'solhint', 'solium']}
let g:ale_fixers = {
      \'go': ['gofmt'],
      \'javascript': ['prettier'],
      \'json': ['jq']}
nnoremap <leader>1 :LspCodeAction<CR>
nnoremap <leader>2 :LspHover<CR>
nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>r :ALEStop<CR>:ALELint<CR>
nnoremap <leader>g :LspDefinition<CR>
nnoremap <leader>s :LspWorkspaceSymbol<CR>

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:echodoc#enable_at_startup = 1
if has('nvim')
  let g:echodoc#type = 'floating'
else
  let g:echodoc#type = 'popup'
endif

runtime macros/matchit.vim
filetype plugin on
