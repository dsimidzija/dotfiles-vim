
set nocompatible

" workaround for neocomplete when lua not present
if !has('lua')
    let g:loaded_neocomplete = 1
endif

execute pathogen#infect()

syntax on
filetype plugin indent on

" colour scheme
set background=dark
if !has('gui_running')
    let g:solarized_termcolors = 256
endif
let g:solarized_italic=0
colorscheme solarized

" slightly more normal leader
let mapleader = ','

" use system clipboard
set clipboard=unnamedplus,unnamed,autoselect

" context scroll
set scrolloff=3
set sidescrolloff=5

" relative line numbers
set relativenumber

" keys
map <leader>n :NERDTreeToggle<CR>
nnoremap <tab> %
vnoremap <tab> %
" vim very magic regex
nnoremap / /\v
vnoremap / /\v
" shortcircuit esc
inoremap <silent> jj <ESC>
" move around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" prevent grep from opening the first match
let g:EasyGrepOpenWindowOnMatch = 0

" nerdtree + vim-session workaround
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0

" gui font...
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
endif

" work compliance...
if has('mac')
    " shieeeet
    set expandtab
endif
set tabstop=4
set shiftwidth=4

" feck off
command! W w

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
if !has('gui_running')
    let g:session_default_name = 'console'
endif
if has('mac')
    " more work stuff
    let g:sessions_project_path = '$HOME/work/projects'
endif

" airline
set laststatus=2
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif
let g:airline_theme = 'powerlineish'

" easytags / tagbar
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
nmap <leader>t :TagbarToggle<CR>

" supertab
let g:SuperTabDefaultCompletionType = "context"
nnoremap <C-g> <C-]> " go to tag, work around ] in shortcut

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>neo_cr_function()<CR>
function! s:neo_cr_function()
    " return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" phpcomplete
let g:phpcomplete_mappings = {
  \ 'jump_to_def': ',g',
  \ }

" vim-better-whitespace
" ask on stack how to call ToggleStripWhitespaceOnSave for all buffers

" syntastic
let g:syntastic_javascript_checkers = ['jshint']

" vim-gitgutter solarized fix
if g:colors_name ==? "solarized"
     highlight clear SignColumn
     highlight GitGutterAdd ctermfg=green guifg=darkgreen
     highlight GitGutterChange ctermfg=yellow guifg=darkyellow
     highlight GitGutterDelete ctermfg=red guifg=darkred
     highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow
endif
