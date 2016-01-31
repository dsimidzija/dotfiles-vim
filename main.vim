
set nocompatible
set mouse=a

" automatically reload config when saving it
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,main.vim source $MYVIMRC
augroup END

autocmd BufNewFile,BufRead *.cson set filetype=coffee
" fix incorrect filedetection for markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" forgot sudo...
cmap w!! w !sudo tee >/dev/null %

" workaround for neocomplete when lua not present
if !has('lua')
   let g:loaded_neocomplete = 1
endif

if !exists('s:pathogen_infected')
    execute pathogen#infect()
    let s:pathogen_infected = 1
endif

syntax on
filetype plugin indent on

" statusbar, tabline
set laststatus=2
set showtabline=2
" prefer text tabs instead of gui
set guioptions-=e

" colour scheme
set background=dark
if !has('gui_running')
    let g:solarized_termcolors = 256
endif
let g:solarized_italic=0
colorscheme solarized
" gnome terminal needs this for some reason, colorscheme destroys the
" background
if &background != 'dark'
	set background=dark
endif

" slightly more normal leader
let mapleader = ','

" use system clipboard
set clipboard=unnamedplus,unnamed,autoselect

" context scroll
set scrolloff=3
set sidescrolloff=5

" relative line numbers
set relativenumber number

" keys
nmap <leader>n <plug>NERDTreeTabsToggle<CR>
nmap <F2> <plug>NERDTreeTabsToggle<CR>
nmap <leader>1 <plug>NERDTreeTabsFind<CR>
nnoremap <F12> :set hlsearch!<CR>:set hlsearch?<CR>
nnoremap <leader>qq :Bdelete<CR>
nnoremap <leader>QQ :bufdo :Bdelete<CR>
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
" visual shifting
vnoremap < <gv
vnoremap > >gv
" faster selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" fix syntax highlighting
nnoremap <F5> :syntax sync fromstart<CR>
inoremap <F5> <C-o>:syntax sync fromstart<CR>
nnoremap <C-g> <C-]> " go to tag, work around ] in shortcut
" replace currently selected text with default register without yanking it
vnoremap p "0p
vnoremap P "0P
" move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" easy ymd
imap <Leader>ymd <C-R>=strftime("%Y-%m-%d")<CR>

" prevent grep from opening the first match
let g:EasyGrepCommand = 1
let g:EasyGrepEveryMatch = 0
let g:EasyGrepJumpToMatch = 0
let g:EasyGrepOpenWindowOnMatch = 1
let g:EasyGrepRecursive = 1

" nerdtree + vim-session workaround
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
let g:nerdtree_tabs_focus_on_files = 1
" double click folder opening
let g:NERDTreeMouseMode = 1
" chdir vim when nerdtree is chdir'd
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowLineNumbers = 1

" gui font...
if has('gui_running')
    if has('mac')
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14
        set guifont=Hack\ Regular:h14
    else
        " apparently the semicolon breaks gvim..
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
        set guifont=Hack\ 13
    endif
endif

" work compliance...
if has('mac')
    " shieeeet
    set expandtab
    autocmd FileType coffee setlocal noexpandtab
endif
set tabstop=4
set shiftwidth=4

" feck off
command! W w
command! Wq wq
command! Wa wa
" edit config in a new tab
command! Conf tabnew ~/.vim/bundle/main.vim

" vim-session
set sessionoptions-=help,options
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_default_to_last = 1
if !has('gui_running')
    let g:session_default_name = 'console'
endif
if has('mac')
    " more work stuff
    let g:sessions_project_path = '$HOME/work/projects'
endif

" airline
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif
let g:airline_theme = 'powerlineish'

" easytags / tagbar / coffeetags
set tags=./.vimtags;/,vimtags;/,./tags;/,tags;/,~/.vimtags
let g:tagbar_phpctags_bin='$HOME/.vim/bundle/phpctags/phpctags'
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_dynamic_files = 1
let g:CoffeeAutoTagFile = '.vimtags'
let g:CoffeeAutoTagIncludeVars = 0
nmap <leader>t :TagbarToggle<CR>

" easygrep
let g:EasyGrepFilesToExclude=".svn,.git,.vimtags,tags,*.sw?,node_modules,bower_components,*.js.map"
let g:EasyGrepSearchCurrentBufferDir = 0 " not very good when you have a file open in ~
let g:EasyGrepWindow = 1 " locationlist; fixes issue with tagbar

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
" neosnippets
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
let g:neosnippet#snippets_directory = '~/.vim/bundle/snippets/'
" <TAB>: completion.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"
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
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['jshint']

" vim-gitgutter solarized fix
if exists("g:colors_name") && g:colors_name ==? "solarized"
     highlight clear SignColumn
     highlight GitGutterAdd ctermfg=green guifg=darkgreen
     highlight GitGutterChange ctermfg=yellow guifg=darkyellow
     highlight GitGutterDelete ctermfg=red guifg=darkred
     highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow
endif

" CtrlP stuff
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  \ },
\ 'fallback': 'find %s -type f'
\ }

" easymotion highlight colors
highlight link EasyMotionTarget Search
highlight link EasyMotionTarget2First Search
highlight link EasyMotionTarget2Second Search
highlight link EasyMotionShade Comment

" annoying piece of shite
autocmd FileType soy setlocal foldmethod=manual
" gitv
autocmd FileType git setlocal foldmethod=manual

" fixes window movement keys with gitv
let g:Gitv_DoNotMapCtrlKey = 1

" vim-extradite
let g:extradite_resize = 0

" syntastic keeps showing this stuping message for <% end %> erb
let g:syntastic_eruby_ruby_quiet_messages =
      \ {'regex': 'possibly useless use of a variable in void context'}
