source $VIMRUNTIME/vimrc_example.vim
""source $VIMRUNTIME/mswin.vim
""behave mswin

set diffexpr=MyDiff()
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""Below options are attached by Kai"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Favarite command ,Comand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set mapleader
let mapleader = ","
let g:mapleader = ","

" 插入模式下用alt + hjkl控制光标
" use Meta key(Windows:Alt) to move cursor in insert mode.
" Note: if system install "Lingoes Translator",
"   you will need change/disabled hot key.
imap <M-k> <Up>
imap <M-j> <Down>
imap <M-h> <left>
imap <M-l> <Right>

" 用<F6>打开当前文件所在文件夹，并选中文件
" Open Windows Explorer and Fouse current file.
" %:p:h " Just Fold Name.
if has("win32")
    nmap <F6> :!start explorer /e,/select, %:p<CR>
    imap <F6> <Esc><F6>
    command! -nargs=0 Explor :!start explorer /e,/select, %:p
    command! -nargs=0 Explorer :!start explorer /e,/select, %:p
endif
"编辑vimrc
map <silent> <leader>ee :e $VIMRUNTIME/../_vimrc<cr>
map <silent> <leader>ss :source $VIMRUNTIME/../_vimrc<cr>
" autoload _vimrc自动载入_vimrc文件，对vim的定制可以立即生效
autocmd! bufwritepost $VIMRUNTIME/../_vimrc source %
set nocompatible
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Consolas:h14:cANSI
set lines=999
set columns=999
au GUIEnter * simalt ~x "启动窗口最大化
colorscheme torte
set cursorline "高亮当前行
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""
" Pretty statusline
"""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%6*\ %{strftime(\"%m/%d/20%y\ -\ %H:%M:%S\")}\  "Current system time
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User6 guifg=#ffff00  guibg=#5b7fbb
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe

function! HighlightSearch()
    if &hls
        return 'H'
    else
        return ''
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File type and encode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencoding=utf-8
set fileencodings=utf-8,cp936,gb2312,gb18030,ucs-bom,big5,gbk,latin1,euc-jp,euc-kr,utf-16
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Common settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set sessionoptions=resize,winpos
set showtabline=0 "Hide the tab bar
set nobackup
set textwidth=200 "disable auto-break of long line
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set go=
set autowrite
set history=100
set mousehide
set clipboard+=unnamed
set iskeyword+=_,$,@,%,#,-
set showcmd
set shortmess=
set report=0
set matchtime=10
set gcr=n:block-blinkon0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fen
set fdl=0
set foldmethod=manual
nnoremap @=((foldclosed(lines('.'))<0)? 'zc' : 'zo')

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
"Tab configuration
"""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrow
"Bclose function ca be found in "Buffer related" section
map <leader>bd :bd<cr>
map <down> <leader>bd
"Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

if v:version>=700
    set switchbuf=usetab
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
"set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracet
set showmatch

"How many tenths of a second to blink
set mat=4

"Highlight search thing
set hlsearch

"选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 自动更改到当前文件所在的目录
autocmd BufEnter * lcd %:p:h

"""""""""""""""""""""""""""""""""""""""""""""""""
"在保存文件时自动去除无效空白，包括行尾空白和文件最后的空行。
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
"""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""
"括号自动补全
"""""""""""""""""""""""""""""""""""""""""""""""""
"inoremap ( ()<ESC>i
inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {}<ESC>i
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
inoremap < <c-r>=OpenPair('<')<CR>
inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    let ol = len(split(getline('.'), a:char, 1))-1
    let cl = len(split(getline('.'), PAIRs[a:char], 1))-1
    if ol==cl
        return a:char . PAIRs[a:char] . "\<Left>"
    else
        return a:char
    endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    " a:quote length is odd.
    if (ql%2)==1
        return a:quote
    elseif getline('.')[col('.') - 1] == a:quote
        return "\<Right>"
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction

""自动补全
set completeopt=longest,menu

""自动补全命令时候使用菜单式匹配列表
set completeopt=longest,menu
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet

"""""""""""""""""""""""""""""""""""""""""""""""""
"gvimfullscreen.dll 全屏插件
" Art+Enter 全屏切换
" Shift + t 降低透明度
" Shift + y 增加透明度
" Shift + r 切换vim在最前面显示
"""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 27 + 29*256*256)
    endfunction
    "Map Alt+Enter to full screen
    map <a-enter> <esc>:call ToggleFullScreen()<cr>
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'InitVim', 0)

    let g:VimAlpha = 240
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction
    "Map Shift+t
    nmap <s-t> <esc>:call SetAlpha(10)<cr> "
    "Map Shift+y
    nmap <s-y> <esc>:call SetAlpha(-10)<cr>

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "map Shift + r to make vim top most!
    nmap <s-r> <esc>: call SwitchVimTopMostMode()<cr>
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Below are for plugins
"Plugins are managed by Vundle tool.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=d:/vim/bundle/vundle
call vundle#rc('d:/vim/bundle/')
" let Vundle manage Vundle required!
Bundle 'gmarik/vundle'
"vim-scripts repos 名稱在這裏搜索http://vim-scripts.org/vim/scripts.html
Bundle 'genutils'
Bundle 'Enhanced-Javascript-syntax'
Bundle 'Better-Javascript-Indentation'
Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'minibufexplorerpp'
Bundle 'httplog'
Bundle 'jbosslog'
Bundle 'dbext.vim'
Bundle 'The-NERD-tree'
Bundle 'NERD_tree-Project'
Bundle 'lookupfile'
Bundle 'lepture/vim-css'
Bundle 'vimwiki'
Bundle 'cscope_macros.vim'
Bundle 'emmet.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"JBossLog plugin"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fu! Log()
    :e \\10.111.5.109\vtba_log\server.log
    :se autoread
endfunction

augroup filetypedetect
  au! BufRead,BufNewFile *.log set filetype=jbosslog
augroup END

command! Log :call Log()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NERD tree plugin
"               key:wfs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeWinPos = "left"
let NERDTreeWinSize = 25
map <F8> :ToggleNERDTree<CR>
map <S-F8> :NERDTreeFromBookmark<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vimwiki plugin
"   key: <leader>ww
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <S-F4> :VimwikiAll2HTML<CR>
map <F4>   :Vimwiki2HTML<CR>
"设置wiki list，当前只有一个"
let g:vimwiki_list = [{'path': 'E:/path/to/vimwiki-1/vimwiki/',
            \ 'path_html': 'E:/My Dropbox/vimwiki_html/',
            \ 'html_header': 'E:/My Dropbox/Public/vimwiki_template/header.htm',
            \ 'html_footer': 'E:/My Dropbox/Public/vimwiki_template/footer.htm',
            \ 'diary_link_count': 5}]
"完成checklist项目会有特别的颜色
let g:vimwiki_hl_cb_checked =1
"不设菜单项
let g:vimwiki_menu=''
"开启语法折叠
let g:vimwiki_folding = 1
"合法html标签
let g:vimwiki_valid_html_tags='b,i,s,u,sub,kbd,del,br,hr,div,code,h1'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ###### calendar ###### "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F7> :Calendar<cr>
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s///e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put =''
  $put =''
  silent %!xmllint --format -
  " xmllint will insert an header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
