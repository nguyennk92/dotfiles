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

" if exists('$TMUX')
"   " insert mode
"   let &t_SI .= "\ePtmux;\e\e[5 q\e\\"
"   " normal mode
"   let &t_EI .= "\ePtmux;\e\e[1 q\e\\"
" 
"   let &t_ti .= "\ePtmux;\e\e[1 q\e\\"
"   let &t_te .= "\ePtmux;\e\e[0 q\e\\"
"   autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
" else 
"   " insert mode
"   let &t_SI .= "\e[5 q"
"   " normal mode
"   let &t_EI .= "\e[1 q"
" 
"   let &t_ti .= "\e[1 q"
"   let &t_te .= "\e[0 q"
"   " reset cursor when vim exits
"   autocmd VimLeave * silent !echo -ne "\033]112\007"
" endif

set laststatus=2
call plug#begin("~/.vim/plugged")
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
