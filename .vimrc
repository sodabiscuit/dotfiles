" @author soda(sodabiscuit@gmail.com) {{{

"set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.9/Python
"set pythonthreehome=/opt/homebrew/Cellar/python@3.9/3.9.9

"nvim@env {{{
if !empty($PYTHON_HOST_PROG)
    let g:python_host_prog  = $PYTHON_HOST_PROG
endif
if !empty($PYTHON3_HOST_PROG)
    let g:python3_host_prog = $PYTHON3_HOST_PROG
endif
if !has('nvim') " Vim 8 only
  pythonx import pynvim
  "pythonx import neovim
endif
" }}} 
"vim-plug@plugins {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'hzchirs/vim-material'
Plug 'rakr/vim-one'
Plug 'mkitt/tabline.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'jlanzarotta/bufexplorer'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'aklt/plantuml-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'jistr/vim-nerdtree-tabs'

Plug 'yegappan/mru'

call plug#end()
" }}} 
"NERDTree@plugins {{{
let NERDTreeWinSize = 25
let NERTChristmasTree = 1
let NERDTreeShowBookmarks = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:nerdtree_tabs_open_on_console_startup = 1
" }}}
"CtrlP@plugins {{{
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
" }}}
"MarkdownPreview@plugins {{{
let g:mkdp_command_for_global = 1
" }}}
"beep off@audio {{{
if has("unix") && !has("gui_running")
    set noerrorbells
    set visualbell
    set t_vb=
endif
" }}}
"normal@view  {{{
if has("gui_running")
set guioptions-=T
set guioptions-=e
set guioptions-=r
set guioptions-=L
set guioptions+=i
set guioptions-=m
set guioptions+=c
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR> 
endif
" }}}
"window@view {{{
function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
if has("gui_win32")
    au GUIEnter * simalt ~x
    map <F11> <esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr> 
    map <F5> <esc>:call libcallnr("vimtweak.dll", "SetAlpha", 235)<cr>
    map <S-F5> <esc>:call libcallnr("vimtweak.dll", "SetAlpha", 255)<cr>
elseif has("gui_macvim")
    set transparency=2
elseif has("gui_gtk2")
    au GUIEnter * call MaximizeWindow()
endif
" }}}
"tabline@view {{{
"set guitablabel=%{tabpagenr()}.%t\ %m
set guitablabel=%t
set showtabline=2
"let g:tablineclosebutton=1
" }}}
"statusline@view {{{
set laststatus=2
set statusline=
set statusline+=%<[%n]
set statusline+=%{fugitive#statusline()}
set statusline+=\ %F\ %h%m%r%=%k
set statusline+=[%{strlen(&ft)?&ft:'none'}]
set statusline+=[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
set statusline+=[%{&ff}]
set statusline+=[ASCII=\%03.3b]
set statusline+=\ %-10.(%l,%c%V%)
set statusline+=\ %P
""set statusline=%<[%n]\ %F\ %h%m%r%=%k[%{strlen(&ft)?&ft:'none'}][%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}][%{&ff}][ASCII=\%03.3b]\ %-10.(%l,%c%V%)\ %P
""set statusline=%t%r%h%w\ [%Y]\ [%{&ff}]\ [%{&fenc}:%{&enc}]\ [%08.8L]\ [%p%%-%P]\ [%05.5b]\ [%04.4B]\ [%08.8l]%<\ [%04.4c-%04.4v%04.4V]
" }}}
"mouse click disabled@keymaps {{{
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
map <2-LeftMouse> <Nop>
"}}}
"conflict@keymaps {{{
if $TERM == 'screen'
    map <C-a> <Nop>
endif
" }}}
"line number shortcuts@keymaps {{{
nmap <silent> <F6> :set number!<CR>
" }}}
"escape key@keymaps {{{
imap jj <Esc> 
" }}}
"clipboard@keymaps {{{
set clipboard=unnamed
if has("unix") && (!has("macunix") || !has("gui_macvim"))
    vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
    nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
    imap <C-v> <Esc><C-v>a
endif
" }}}
"tab@keymaps {{{
map <C-TAB> :tabnext<cr>
nmap <C-TAB> :tabnext<cr>
imap <C-TAB> <esc> :tabnext<cr>
map <C-Right> :tabnext<cr>
nmap <C-Right> :tabnext<cr>
imap <C-Right> <esc> :tabnext<cr>
map <C-Left> :tabprevious<cr>
nmap <C-Left> :tabprevious<cr>
imap <C-Left> <esc> :tabprevious<cr>
" }}}
"visual shifting@keymaps {{{
vnoremap < <gv
vnoremap > >gv 
" }}}
"leader key@keymaps {{{
let mapleader=","
" }}}
"mouse enabled@keymaps {{{
if has('mouse')
    set mouse=a
endif
" }}}
"NERDTree@keymaps {{{
" nmap <silent> <leader>nt :NERDTree<cr>
" nmap <silent> <leader>ntc :NERDTreeClose<cr>
" nmap <silent> <leader>nt :NERDTreeToggle<cr>
" nmap <silent> <C-P>:NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeToggle<cr>
" }}}
"display@editor {{{
set autochdir
set nocompatible
set langmenu=none
" language messages none
set wrap
set nolinebreak
set wildmenu
set ruler
set number
set numberwidth=4
set equalalways
set nowrap
"set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set linespace=4
" set columns=195
" set lines=44
set whichwrap=b,s,<,>,[,] "auto jump next line
set backspace=indent,eol,start
set fdm=marker
" }}}
"syntax@editor {{{
syntax on
filetype plugin on
filetype indent on
" }}}
"encoding@editor {{{
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set fileencoding=utf-8
let &termencoding=&encoding
if has("gui_running")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    " language messages zh_CN.utf-8
    " language messages en_US.utf-8
    " language messages en    
endif
set fileformat=unix
set fileformats=dos,unix
" }}}
"font@editor {{{
if has("gui_running")
    if has("gui_macvim")
        set macligatures
    endif
    if has("gui_win32")
        set guifont=Panic_Sans:h11:cANSI
        set guifontwide=Microsoft_JhengHei:h12
    else
        "set guifont=Sarasa\ Mono\ CL:h14
        "set guifont=Cascadia\ Code\ PL:h14
        "set guifont=Fira\ Code:h14
        set guifont=JetBrains\ Mono:h14
        " set guifontwide=WenQuanYi\ Micro\ Hei\ 12    
    endif
endif
" }}}
"cursor@editor {{{
if has("gui_macvim")
nmap <S-A-F11> :set cursorline!<BAR>set nocursorline?<CR>
nmap <S-A-F12> :set cursorcolumn!<BAR>set nocursorcolumn?<CR>
else
nmap <S-F11> :set cursorline!<BAR>set nocursorline?<CR>
nmap <S-F12> :set cursorcolumn!<BAR>set nocursorcolumn?<CR>
endif
" }}}
"storage_session@file {{{
set history=100
set nobackup
set nowritebackup
set noswapfile
set backupext=.bak
set bufhidden=hide
" }}}
"search@file {{{
set incsearch
set hlsearch
" }}} 
"deoplete@editor {{{
let g:deoplete#enable_at_startup = 1
" }}} 
"themes@editor {{{
if has('termguicolors')
  set termguicolors
endif
set background=dark
" set background=light
colorscheme vim-material
let g:material_style='palenight'
" let g:material_style='oceanic'
" colorscheme one
" }}} 
"global theme overrides@editor {{{
hi TabLine      guifg=NONE guibg=#455A64 gui=none
hi TabLineSel   guifg=NONE guibg=#263238 gui=bold
hi TabLineFill  guifg=NONE guibg=#455A64 gui=none
"hi TabLine      ctermfg=254 ctermbg=238 cterm=none
"hi TabLineSel   ctermfg=231 ctermbg=235 cterm=bold
"hi TabLineFill  ctermfg=254 ctermbg=238 cterm=none
" }}} 
" }}}
