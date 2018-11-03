" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic' " For eslint integration
Plug 'mtscout6/syntastic-local-eslint.vim'

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

" Add row numbers
set number

" And cursor position
set ruler

" Set guidelines at 100 and 120 characters
set colorcolumn=100,120

" Highlight current search term matches
set hlsearch

" Change tabs to spaces by default
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Syntastic / eslint integration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lintfile --'

function! SyntasticCheckHook(errors)
  if !empty(a:errors)
    let g:syntastic_loc_list_height = min([len(a:errors), 5])
  endif
endfunction
