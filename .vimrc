" show.murai vim life
set nocompatible

" 行番号を表示
set number

" 相対行番号を表示
set relativenumber

" カーソル行に下線を表示
set cursorline

" クリップボードを共有
set clipboard+=unnamed

" inoremap -> インサートモードのキーバインド設定
inoremap <C-d> <del>

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

set fileformats=unix,dos

" indent ---------
set smarttab
set expandtab
set shiftround

" ---- search behavior 
set incsearch
set ignorecase
set smartcase

"set nowrapscan
set wrapscan
set hlsearch

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
" if v:version >= 703
"  set colorcolumn=79
" endif
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
    set lines=63 columns=250 " ウィンドウサイズをセット はみだした部分は自動的に修正させて画面いっぱいに表示させる
    set guioptions-=T " ウィンドウ上部のタブ部分を無効に
    set imdisable " IMEを無効に
    colorscheme desert " カラースキーマを指定
endif

" netrwのnoteを表示させない
let g:netrw_localcopycmd=''

" nnoremap -> ノーマルモードのキーバインド設定
nnoremap ; :
nnoremap : ;

" 以下あんま最低限ではないもの
nnoremap [Show] <Nop>
nmap <Space>s [Show]
" いつでもhelpを開けてうれしい
nnoremap [Show]h  :<C-u>tab help<Space>

nnoremap Y y$
" Ctrl + C は、`insert modeの強制終了`なので微妙に挙動がかわる。うざいので置き換える
inoremap <C-c> <Esc>

" ---- insert mode これはお好みで
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


set runtimepath+=/usr/local/Cellar/go/1.1.2/libexec/misc/vim

" Neobundle add runtimepath
 if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Neobundle
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'

NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'editorconfig/editorconfig-vim'

" for python
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'andviro/flake8-vim'
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'cohama/vim-hier'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'davidhalter/jedi-vim.git'
NeoBundle 'hachibeeDI/python_hl_lvar.vim'

" for go
NeoBundle 'nsf/gocode'
NeoBundle 'Blackrush/vim-gocode'

" Colour Scheme Plugin
NeoBundle 'ujihisa/unite-colorscheme'

syntax enable
filetype plugin indent on
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" neosnippet settings
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1


" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" over.vim {{{
" over.vimの起動
nnoremap <silent> mm :OverCommandLine<CR>
" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
" }}}


" Flake8-vim {{{
let g:PyFlakeOnWrite = 1
" 無視する警告の種類
" E501 => 行ごとの文字数制限, E121 => 次行のインデントはひとつだけ, E303 => 改行の数が多すぎる
let g:PyFlakeDisabledMessages = 'E501,E121,E303'
" エラー行のマーカー。hierあればいらないので非表示に
let g:PyFlakeSigns = 0
" flake8-autoをかけるためのコマンド。visual-modeでの範囲選択に対応
let g:PyFlakeRangeCommand = 'Q'
" }}}

" キーバインドの設定は好みで。以下は例
nnoremap [Show] <Nop>
nmap <Space>s [Show]
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


" Unite -----------
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    ,u [unite]

nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
        \ -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
        \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
        \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
        \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]d
        \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]ma
        \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
        \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]s
        \ :<C-u>Unite -buffer-name=files -no-split
        \ jump_point file_point buffer_tab
        \ file_rec:! file file/new file_mru<CR>
colorscheme molokai

" Start insert.
"let g:unite_enable_start_insert = 1
"let g:unite_enable_short_source_names = 1

" To track long mru history.
"let g:unite_source_file_mru_long_limit = 3000
"let g:unite_source_directory_mru_long_limit = 3000

" Like ctrlp.vim settings.
"let g:unite_enable_start_insert = 1
"let g:unite_winheight = 10
"let g:unite_split_rule = 'botright'

" Prompt choices.
"let g:unite_prompt = '❫ '
"let g:unite_prompt = '» '
let g:unite_source_history_yank_enable =1  "history/yankの有効化

autocmd FileType unite nnoremap <silent> <buffer> <esc><esc> <esc>:q<CR>
autocmd FileType unite inoremap <silent> <buffer> <esc><esc> <esc>:q<CR>

let g:unite_source_file_mru_limit = 200
let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_abbr_highlight = 'TabLine'

" For optimize.
let g:unite_source_file_mru_filename_format = ''

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"\u2b64":""}',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
      \ }

function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>
