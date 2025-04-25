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
set timeoutlen=500
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
  autocmd VimEnter * PlugInstall --sync | source $MYVIMR
endif

if !has('nvim')
  source $VIMRUNTIME/defaults.vim
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
Plug 'Valloric/ListToggle'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rhysd/vim-lsp-ale'
Plug 'Shougo/echodoc.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'tomlion/vim-solidity'
if !has('nvim')
    Plug 'rhysd/vim-healthcheck'
endif
call plug#end()

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_fold_enabled = 1
let g:lsp_semantic_enabled = 0
let g:lsp_text_edit_enabled = 0
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_experimental_workspace_folders = 1
nmap <plug>() <Plug>(lsp-float-close)

" ALE configuration
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \'_': ['vim-lsp']}
let g:ale_fixers = {
      \'*': ['trim_whitespace'],
      \'go': ['gofmt'],
      \'javascript': ['prettier-eslint'],
      \'typescript': ['prettier'],
      \'json': ['jq'],
      \'python': ['black'],
      \'solidity': ['forge'],
      \'html': ['prettier'],
      \'yaml': ['prettier'],
      \'rust': ['rustfmt']}
let g:ale_javascript_prettier_options='--plugin=prettier-plugin-solidity'

nnoremap <leader>1 :LspCodeAction<CR>
nnoremap <leader>2 :LspHover<CR>
nnoremap <leader>3 :LspImplementation<CR>
nnoremap <leader>4 :LspCallHierarchyIncoming<CR>
nnoremap <leader>5 :LspCallHierarchyOutgoing<CR>
nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>r :ALEStop<CR>:ALELint<CR>
nnoremap <leader>g :LspDefinition<CR>
nnoremap <leader>s :LspWorkspaceSymbol<CR>
nnoremap <leader>t :LspPreviousDiagnostic<CR>
nnoremap <leader>y :LspNextDiagnostic<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap <leader>c :NERDTreeFind<CR>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:echodoc#enable_at_startup = 1
if has('nvim')
  let g:echodoc#type = 'floating'
else
  let g:echodoc#type = 'popup'
endif

runtime macros/matchit.vim
filetype plugin on

" Asyncomplete
imap <Nul> <Plug>(asyncomplete_force_refresh)

hi Pmenu ctermbg=DarkGray ctermfg=white

cnoreabbrev LCHI :LspCallHierarchyIncoming
cnoreabbrev LCHO :LspCallHierarchyOutgoing

let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')
" for asyncomplete.vim log
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')
"
let g:lsp_settings = {
  \ "eclipse-jdt-ls": {
  \   'cmd': [
  \     'java',
  \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  \     '-Dosgi.bundles.defaultStartLevel=4',
  \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
  \     '-Dlog.level=ALL',
  \     '-noverify',
  \     '-Dfile.encoding=UTF-8',
  \     '-Xmx1G',
  \     '-jar',
  \     expand('~/eclipse-jdt-ls/plugins/org.eclipse.equinox.launcher_*.jar'),
  \     '-configuration',
  \     expand('~/eclipse-jdt-ls/config_mac'),
  \     '-data',
  \     expand('~/eclipse-jdt-ls/workspace')
  \   ]
  \ }
\ }
" Flux file type
au BufRead,BufNewFile *.flux
set filetype=flux

if executable('flux-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'flux lsp',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flux-lsp']},
        \ 'whitelist': ['flux'],
        \ })
endif
if executable('nomicfoundation-solidity-language-server')
    au User lsp_setup call lsp#register_server({
        \   'name': 'solidity',
        \   'cmd': {server_info->[&shell, &shellcmdflag, 'nomicfoundation-solidity-language-server --stdio']},
        \   'allowlist': ['solidity'],
        \   'root_uri':{server_info->lsp#utils#path_to_uri(
        \	    lsp#utils#find_nearest_parent_file_directory(
        \	    	lsp#utils#get_buffer_path(),
        \	    	['.git/']
        \	  ))},
        \ })
endif

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings = {
\ 'efm-langserver': {
\   'disabled': v:false
\ },
\ }

autocmd BufWritePre *.ts,*.tsx call execute('LspDocumentFormatSync --server=efm-langserver')

nnoremap <space> za
au BufNewFile,BufRead *.py
   \ set tabstop=4 |
   \ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set textwidth=79 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

let g:nuuid_no_mappings = 1
nnoremap <leader>9 <Plug>Nuuid
let @u='\9bbbbbbbbd28l'
