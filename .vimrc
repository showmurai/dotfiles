" show.murai vim life


" ===============dpp.vim setting===============

set nocompatible

" Set dpp base path (required)
const s:dpp_base = expand('~/.cache/dpp/')

" Set dpp source path (required)
const s:dpp_src = expand('~/.vim/bundles/dpp.vim')
const s:denops_src = expand('~/.vim/bundles/denops.vim')

" Set dpp runtime path (required)
execute 'set runtimepath^=' .. s:dpp_src

if s:dpp_base->dpp#min#load_state()
  " NOTE: dpp#make_state() requires denops.vim
  execute 'set runtimepath^=' .. s:denops_src

  " Bootstrap: add ext/protocol plugins to runtimepath
  for s:plugin in [
        \ 'dpp-ext-installer',
        \ 'dpp-ext-lazy',
        \ 'dpp-ext-toml',
        \ 'dpp-protocol-git',
        \ ]
    execute 'set runtimepath^=' .. expand('~/.vim/bundles/' .. s:plugin)
  endfor

  autocmd User DenopsReady
  \ : echohl WarningMsg
  \ | echomsg 'dpp load_state() is failed. Rebuilding cache...'
  \ | echohl NONE
  \ | call dpp#make_state(s:dpp_base, expand('~/.vim/dpp/dpp.ts'))
endif

autocmd User Dpp:makeStatePost
\ : echohl MoreMsg
\ | echomsg 'dpp make_state() done!'
\ | echohl NONE

" Auto rebuild cache when config files are updated
autocmd BufWritePost *.toml,*.ts,vimrc,.vimrc
\ : if !dpp#check_files()->empty()
\ |   call dpp#make_state()
\ | endif

" Install plugins command
command! DppInstall call dpp#async_ext_action('installer', 'install')
" Update plugins command
command! DppUpdate call dpp#async_ext_action('installer', 'update')

filetype indent plugin on

if has('syntax')
  syntax on
endif


" ===============VIM normal setting===============

" 行番号を表示
set number

" 相対行番号を表示
set relativenumber

" カーソル行に下線を表示
set cursorline

" クリップボードを共有
set clipboard+=unnamed

" インサートモードのキーバインド設定
inoremap <C-d> <del>

" マルチバイト文字がノーマルモードで暴れないため
if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

" エンコードの設定
set fileformats=unix,dos
set fileencodings=utf-8,cp932,sjis,euc-jp,latin1

" インデント
set smarttab
" タブのかわりにスペースを使う
set expandtab
" 'shiftwidth'の倍数でインデントを入れる
set shiftround

" インクリメンタルサーチ
set incsearch
set ignorecase
set smartcase

" 検索がファイル末尾まで行ったらファイル先頭に戻る
set wrapscan
set hlsearch

" タブを画面上でなん文字で表示するか
set tabstop=2
" use 4 as default tab width, and will customize in $MY_VIMRUNTIME/after/ftplugin/*.vim
set shiftwidth=4 softtabstop=4
" A list of file patterns is ignored when expanding
set wildignore=*.o,*.obj,*.pyc
" a list of deletable
set backspace=eol,indent,start
" disable bell
set t_vb=
set novisualbell

" have to set, before setting colorscheme-command
set t_Co=256

set list
set listchars=tab:>-,trail:~
" disable auto textwraping
set textwidth=0
set wrap

" unicode文字の認識
set ambiwidth=double

"閉じカッコが入力されたとき、対応するカッコを表示する
set showmatch
" 括弧を入力した時にカーソルが移動しないように設定
set matchtime=0
" set default register is unnamed register. (same as OS's clipboard)
set clipboard=unnamed
" mouse surport
set mouse=a
"コマンド実行中は再描画しない
set lazyredraw
"高速ターミナル接続を行う
set ttyfast

set laststatus=2
set showtabline=2

"折りたたみを無効
set nofoldenable

" MacVim Setting
if has('gui_macvim')
    set transparency=10 " 透明度を指定
    set guifont=Osaka-Mono:h20 " フォント指定
    set lines=100 columns=300 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
    set guioptions-=T " ウィンドウ上部のタブ部分を無効に
    set imdisable " IMEを無効に
    colorscheme desert " カラースキーマを指定
endif

" netrwのnoteを表示させない
let g:netrw_localcopycmd=''

" nnoremap -> ノーマルモードのキーバインド設定
nnoremap ; :
nnoremap : ;

nnoremap [Show] <Nop>
nmap <Space>s [Show]
" いつでもhelpを開けてうれしい
nnoremap [Show]h  :<C-u>tab help<Space>

nnoremap Y y$
" Ctrl + C は、`insert modeの強制終了`なので微妙に挙動がかわる。うざいので置き換える
inoremap <C-c> <Esc>

"emacs like key-bind in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-h> <Backspace>
cnoremap <C-d> <Del>

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" move current directory on the above of file is editing.
" via: <http://vim-users.jp/2009/09/hack69/> {{{
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" 検索結果のハイライトをESC連打で消す
set hlsearch
noremap <Esc><Esc> :nohlsearch<CR><Esc>

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" doc string は表示しない
autocmd FileType python setlocal completeopt-=preview

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Hier key-bindings
nnoremap [Show]hc  :<C-u>HierClear<CR>
nnoremap [Show]hs  :<C-u>HierStart<CR>
nnoremap [Show]hp  :<C-u>HierStop<CR>
nnoremap [Show]hu  :<C-u>HierUpdate<CR>
noremap ^[OA <Up>
noremap ^[OB <Down>
noremap ^[OC <Right>
noremap ^[OD <Left>

" preview error line in quickfix
nnoremap <M-p> :<C-u>cp<CR>
" next error line in quickfix
nnoremap <M-n> :<C-u>cn<CR>
