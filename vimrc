" Setting some decent VIM settings for programming

" This source file comes from git-for-windows build-extra repository (git-extra/vimrc)

 

ru! defaults.vim                " Use Enhanced Vim defaults

set mouse=                      " Reset the mouse setting from defaults

aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below

let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

 

set ai                          " set auto-indenting on for programming

set showmatch                   " automatically show matching brackets. works like it does in bbedit.

set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"

set laststatus=2                " make the last line where the status is two lines deep so you can see status always

set showmode                    " show the current mode

set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows

set wildmode=list:longest,longest:full   " Better command line completion

 

" Show EOL type and last modified timestamp, right after the filename

" Set the statusline

set statusline=%f               " filename relative to current $PWD

set statusline+=%h              " help file flag

set statusline+=%m              " modified flag

set statusline+=%r              " readonly flag

set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...

set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp

set statusline+=%=              " Rest: right align

set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column

set statusline+=\ %P            " Position in buffer: Percentage

 

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible

  if &t_Co == 8

    set t_Co = 256              " Use at least 256 colors

  endif

  " set termguicolors           " Uncomment to allow truecolors on mintty

endif

"------------------------------------------------------------------------------

" Only do this part when compiled with support for autocommands.

if has("autocmd")

    " Set UTF-8 as the default encoding for commit messages

    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

 

    " Remember the positions in files with some git-specific exceptions"

    autocmd BufReadPost *

      \ if line("'\"") > 0 && line("'\"") <= line("$")

      \           && &filetype !~# 'commit\|gitrebase'

      \           && expand("%") !~ "ADD_EDIT.patch"

      \           && expand("%") !~ "addp-hunk-edit.diff" |

      \   exe "normal g`\"" |

      \ endif

 

      autocmd BufNewFile,BufRead *.patch set filetype=diff

 

      autocmd Filetype diff

      \ highlight WhiteSpaceEOL ctermbg=red |

      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

endif " has("autocmd")

 

"文件代码形式utf-8

set encoding=utf-8

set termencoding=utf-8

set fileencoding=utf-8

set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr

 

 

"提示乱码

"language messages zh_CN.utf-8

 

 

"vim list debug ifx

"source $VIMRUNTIME/delmenu.vim

"source $VIMRUNTIME/menu.vim

 

 

set nobackup

set autoread         "外部检测auto

set nocompatible                "KILL-VI一致性

" 折叠

set foldenable                     "允许折叠

set fdm=syntax                   " 按语法折叠

set fdm=manual                 "手动

 

 

set novisualbell                   "no闪烁

set number                                "行号

set relativenumber              "相对行号

set laststatus=2                   "显示状态行

set ruler                "当前行下划线

set showcmd                      "显示输入命令

 

"语法高亮

syntax enable

syntax on

 

"进退x**

set tabstop=4

set softtabstop=4

set backspace=2

 

set autoindent

set cursorline

 

set hlsearch

set incsearch

set ignorecase

set showmatch

 

set smartindent

set cindent

 

"代码折叠

set foldenable

"折叠方法

"manual         手工折叠

"indent          缩进表示

"expr             表达式折叠

"syntax          语法定义折叠

"diff        没有更改的文本折叠

"maraker 标记折叠，默认：{{{和}}}

set foldmethod=syntax

"在左侧显示

set foldcolumn=4

 

"7行上下滚动始终在中间

set so=7

 

 

"重载保存文件

autocmd BufWritePost $MYVIMRC source $MYVIMRC

autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')

 

"智能当前行高亮

autocmd InsertLeave,WinEnter * set cursorline

autocmd InsertLeave,WinEnter * set nocursorline

 

"关键字补全

set complete-=i                         "disable scanning included files

set complete-=t                         "disable searching tags

 

"colorscheme desert

syntax on

 

 

"----------------插件

 

"Nerdtree==================

"启动时自动打开

"autocmd vimenter * NERDTree        

 

"打开一个目录同时TREE打开，关闭文件时TREE自动关闭

autocmd StdinReadPre * let s:std_in=1

autocmd vimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

 

"打开的同时链接其历史记录(open tree automatically when vim starts up on

"opening a directory)

autocmd StdinReadPre * let s:std_in=1

autocmd vimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

 

"close vim if the only windows left open is a nerdtree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

 

"F2启动/关闭

map <F2> :NERDTreeToggle<CR>   

 

"wiki============================

set nocompatible

       filetype plugin on

       syntax on

 

"goyo=============================

":Goyo                  "toggle Goyo

":Goyo[demension]

":Goyo!                 "off

 

 

"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

call plug#begin('~/.vim/plugged')

       Plug 'scrooloose/nerdtree'                        "目录树

       Plug 'vimwiki/vimwiki'                             

       Plug 'vim-airline/vim-airline'                    "状态列增强

       Plug 'tpope/vim-surround'

       Plug 'ctrlpvim/ctrlp.vim'                            "模糊搜索

       Plug 'junegunn/goyo.vim'                        "简化阅读

       Plug 'terryma/vim-multiple-cursors'                "V增强

       Plug 'jreybert/vimagit'

       Plug 'vim-syntastic/syntastic'

call plug#end()
