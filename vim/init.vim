set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors

" Sets cursor styles
" Block in normal, line in insert, underline in replace
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

" Python autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-pyright' " :CocInstall coc-pyright

Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'feline-nvim/feline.nvim', { 'branch': '0.5-compat' }
Plug 'Hitesh-Aggarwal/feline_one_monokai.nvim'
Plug 'nvim-tree/nvim-web-devicons'
set cmdheight=1 " If 0, doing things like `n` with no results will require pressing Enter

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'kshenoy/vim-signature'
Plug 'vimwiki/vimwiki'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Copilot
Plug 'github/copilot.vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

" Easier tab usage
:nmap :t :tabedit<Space>
nnoremap <C-H> gT
nnoremap <C-L> gt

" Add row numbers
set number

" And cursor position
set ruler

" Set guidelines at 100 and 120 characters
set colorcolumn=100,120

" Highlight current search term matches
set hlsearch

" Incrementally highlight as you change the search terms
set incsearch

" Toggle smartcase by default
set ignorecase
set smartcase

" Change tabs to spaces by default
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Show spaces as characters
set list listchars=tab:>-,space:·

" Vinegar setting without full plugin
nmap - :Exp <CR>

" Gitgutter
" Set update time to less than default 4 seconds
set updatetime=200

" 'import {name} from {path}' includes a filepath
set include=from

" VimWiki
set nocompatible
" filetype plugin on " Already set
syntax on

" ---------------------------------------------------------------------
" Intellisense functionality is configured below because I am weak.
" coc.nvim (https://github.com/neoclide/coc.nvim?tab=readme-ov-file)

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Also remember that we need to remove the gd mapping from vim-go as we’ll be using the coc functionality
let g:go_def_mapping_enabled = 0

" Mappings fzf
" Function to capture the current command before launching FZF
function! s:launch_fzf_cmd() abort
    " Store the current command line
    let s:saved_cmdline = getcmdline()
    let s:saved_cmdpos = getcmdpos()

    " Exit command mode temporarily
    call feedkeys("\<C-c>", 'n')

    " Launch FZF after returning to normal mode
    call timer_start(0, { -> s:trigger_fzf() })

    return ''
endfunction

function! s:trigger_fzf() abort
    let l:opts = {
        \ 'source': 'git ls-files',
        \ 'sink': function('s:handle_file_selection'),
        \ 'options': ['--preview', 'cat {}'],
        \ }
    call fzf#run(fzf#wrap(l:opts))
endfunction

function! s:handle_file_selection(selected) abort
    " If we have a selection, rebuild and execute the command
    if !empty(a:selected)
        let l:new_cmdline = strpart(s:saved_cmdline, 0, s:saved_cmdpos - 1)
                    \ . a:selected
                    \ . strpart(s:saved_cmdline, s:saved_cmdpos - 1)

        " Return to command mode and execute the command immediately
        call timer_start(0, { -> feedkeys(":" . l:new_cmdline . "\<CR>", 'n') })
    endif
endfunction
" Map <C-Space> in command mode
cnoremap <C-Space> <C-\>e<SID>launch_fzf_cmd()<CR>

" I feel pretty
set background=dark
let g:palenight_color_overrides = {
\    'comment_grey': { 'gui': '#f0e797', "cterm": "180", "cterm16": "3" },
\}
colorscheme palenight
let g:airline_theme="palenight"

" this seems to reflect the line you moved _from_ when moving the cursor
" up/down
" let g:airline_section_x ='%{get(b:,"coc_git_blame","")}'
" Be sure to set git.addGBlameToBufferVar to true in CocConfig

lua require('init')
