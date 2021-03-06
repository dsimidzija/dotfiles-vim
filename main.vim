set nocompatible
set mouse=a
set nomousehide
set autoread
set foldlevelstart=99
set colorcolumn=120
set updatetime=300
set signcolumn=auto
syntax on
filetype plugin indent on

" statusbar, tabline
set laststatus=2
set showtabline=2
" prefer text tabs instead of gui
set guioptions-=e
" show cursorline
set cursorline

" slightly more normal leader
let mapleader = ','

" use system clipboard
if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
else
    set clipboard=unnamed
endif

" context scroll
set scrolloff=3
set sidescrolloff=5

" relative line numbers
set relativenumber number

" enable smartcase search
set ignorecase
set smartcase

" automatically reload config when saving it
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,main.vim source $MYVIMRC
augroup END

" forgot sudo...
cmap w!! w !sudo tee >/dev/null %

" normal backspace
set backspace=indent,eol,start

" must be defined before the plug#begin below
let g:coc_global_extensions = [
\ 'coc-vimlsp',
\ 'coc-snippets',
\ 'coc-python',
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-yaml',
\ 'coc-sh'
\ ]

call plug#begin('~/.vim/plugged')

" dependencies
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'xolox/vim-misc'

" essentials
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dkprice/vim-easygrep'
Plug 'dsimidzija/vim-nerdtree-ignore'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Lokaltog/vim-easymotion'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'Shougo/context_filetype.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-session'

Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'skammer/vim-css-color'
Plug 'xolox/vim-easytags'
Plug 'terryma/vim-expand-region'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'groenewege/vim-less'
Plug 'terryma/vim-multiple-cursors'
Plug 'milkypostman/vim-togglelist'
Plug 'nelstrom/vim-visual-star-search'
Plug 'wesQ3/vim-windowswap'
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mattn/emmet-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'maralla/validator.vim'
Plug 'majutsushi/tagbar'

" filetypes & frameworks
Plug 'python-mode/python-mode'
Plug 'tpope/vim-rails'
Plug 'andrewstuart/vim-kubernetes'
Plug 'briancollins/vim-jst'
Plug 'chrisbra/csv.vim'
Plug 'duganchen/vim-soy'
Plug 'evidens/vim-twig'
Plug 'hashivim/vim-terraform'
Plug 'mustache/vim-mustache-handlebars'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" git
Plug 'airblade/vim-gitgutter'
Plug 'int3/vim-extradite'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" unused ATM
"Plug 'kchmck/vim-coffee-script'
"Plug 'ryanoasis/vim-devicons'  " killing performance with constant refreshes
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'vim-php/phpctags'
"Plug 'vim-php/tagbar-phpctags.vim'
"Plug 'vitalk/vim-simple-todo'

" colorschemes
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'whatyouhide/vim-gotham'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'bluz71/vim-nightfly-guicolors'

call plug#end()

" keys
"inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
"let g:coc_snippet_next = '<TAB>'
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-k> coc#refresh()
nnoremap <silent> <c-f> :call <SID>show_documentation()<CR>
"augroup coc
"    autocmd!
"    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-references)
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <F1> <nop>
inoremap <F1> <nop>
vnoremap <F1> <nop>
nnoremap <F3> :Gstatus<CR>
nnoremap <F10> :GrepOptions<CR>
nnoremap <F11> :tabdo :windo lcl\|ccl<CR>
nnoremap <F12> :set hlsearch!<CR>:set hlsearch?<CR>
" use tab to find file in nerdtree, and tab again to close nerdtree
"nnoremap <S-Tab> :NERDTreeToggle<CR>
nnoremap <S-Tab> :NERDTreeFind<CR>
"autocmd FileType nerdtree nnoremap <buffer> <Tab> :NERDTreeClose<CR>
autocmd FileType nerdtree nnoremap <buffer> <S-Tab> :NERDTreeClose<CR>
" delete buffer to clean up the active session
nnoremap <leader>qq :Bdelete<CR>
nnoremap <leader>QQ :bufdo :Bdelete<CR>
" vim very magic regex
nnoremap / /\v
vnoremap / /\v
" CRO keyboard layout easier search
nmap _ /
vmap _ /
" shortcircuit esc
inoremap <silent> jj <ESC>
" move around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" easy tab navigation
map <S-H> gT
map <S-L> gt
" fix wrapped lines up/down navigation
noremap j gj
noremap k gk
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
" quickfix open in new tab
autocmd BufReadPost quickfix nnoremap <buffer> <C-t> <C-w><CR><C-w>T
" easygrep
nnoremap <C-e> :copen<CR>
" quick way to add blank lines
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
" surround shortcuts
nmap ` ysiw`
" toggle tagbar
nmap <leader>t :TagbarToggle<CR>

" easygrep
let g:EasyGrepCommand = 1
let g:EasyGrepEveryMatch = 0
let g:EasyGrepJumpToMatch = 0
let g:EasyGrepOpenWindowOnMatch = 1
let g:EasyGrepRecursive = 1
let g:EasyGrepFilesToExclude=".svn,.git,.vimtags,tags,*.sw?,node_modules,bower_components,*.py.orig,*.js.map,*.apib,htmlcov,_build,build"
let g:EasyGrepSearchCurrentBufferDir = 0 " not very good when you have a file open in ~
let g:EasyGrepWindow = 0 " for compatibility with syntastic

" nerdtree + vim-session workaround
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
let g:nerdtree_tabs_focus_on_files = 1
" double click folder opening
let g:NERDTreeMouseMode = 1
" chdir vim when nerdtree is chdir'd
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowLineNumbers = 1

" NERDCommenter
let g:NERDDefaultAlign = 'left'

" gui font...
if has('gui_running')
    "set guifont=Hack\ 13
    set guifont=Fira\ Code\ 14 " ttf-fira-code
    "set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 14
endif

set expandtab
set tabstop=4
set shiftwidth=4

" feck off
command! W w
command! Q q
command! Qa qa
command! QA qa
command! Wq wq
command! WQ wq
command! Wa wa
command! WA wa
command! -nargs=1 Tabe tabe <args>
" edit config in a new tab
command! Conf tabnew ~/.vim/repo/main.vim
" edit snippet in a new tab
command! -nargs=1 Snip tabnew ~/.vim/repo/snippets/<args>.snippets
" leave only current buffer open
command! Only silent! execute "%bd|e#|bd#"

" vim-session
set sessionoptions-=help,options,blank
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
if !has('gui_running')
    let g:session_default_name = 'console'
endif
if isdirectory($HOME.'/work/projects')
    let g:sessions_project_path = '$HOME/work/projects'
endif
let s:hostname = substitute(system('hostname'), '\n', '', '')
if s:hostname == "NEMATODA"
    " workaround for the idiotic DELL XPS keyboard layout
  noremap <PageUp> <nop>
  noremap <PageDown> <nop>
endif

" airline
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif
"let g:airline_theme = 'powerlineish'
let g:airline_theme = 'cool'

" easytags / tagbar / coffeetags
set tags=./.vimtags;/,vimtags;/,./tags;/,tags;/,~/.vimtags
"let g:tagbar_phpctags_bin='$HOME/.vim/bundle/phpctags/phpctags'
let g:easytags_suppress_ctags_warning = 1
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_dynamic_files = 1
let g:CoffeeAutoTagFile = '.vimtags'
let g:CoffeeAutoTagIncludeVars = 0

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/repo/snippets']
let g:UltiSnipsExpandTrigger="<s-cr>"
let g:UltiSnipsListSnippets="<c-s-cr>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
" iterm workaround
imap ✠ <s-cr>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" phpcomplete
let g:phpcomplete_mappings = {
    \ 'jump_to_def': ',g',
    \ }

" vim-better-whitespace
" ask on stack how to call ToggleStripWhitespaceOnSave for all buffers

" syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {'mode':'passive'}
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['pylint']
nnoremap <C-w>e :SyntasticCheck<CR>
nnoremap <C-w>f :SyntasticToggleMode<CR>

" vim-gitgutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

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

" validator
let g:validator_python_checkers = ["flake8"]
let g:validator_permament_sign = 1

let g:python_highlight_all=1
source ~/.vim/repo/python.vim
let g:pymode_lint = 0
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 120
let g:pymode_virtualenv = 1
let g:pymode_run = 0

" pandoc + pandoc markdown
let g:pandoc#modules#disabled = ["formatting", "folding", "bibliographies"]
let g:pandoc#formatting#mode = "hA"
let g:pandoc#filetypes#pandoc_markdown = 0

" used to format json in a buffer, as dumped by python in terminal
function! JsonF()
    %s/'/"/ge
    %s/\vDecimal\("([0-9.]+)"\)/\1/ge
    %!python -m json.tool
endfunction

command! Json call JsonF()

" enable external .vimrc
"set exrc
"set secure

" colour scheme
set background=dark
if !has('gui_running')
    let g:solarized_termcolors = 256
endif
let g:solarized_italic=0
let ayucolor="dark"
let g:gruvbox_contrast_dark = "hard"
"colorscheme solarized
"colorscheme papaya
"colorscheme dracula
colorscheme gruvbox
"colorscheme gotham
"colorscheme iceberg
"colorscheme ayu " missing tabs
"colorscheme nord
"colorscheme jellybeans " missing tabs
"colorscheme nightfly
" gnome terminal needs this for some reason, colorscheme destroys the
" background
if &background != 'dark'
    set background=dark
endif
