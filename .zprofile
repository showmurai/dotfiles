# 言語設定
export LANG=ja_JP.UTF-8

BREW_PATH=`/usr/local/bin/brew --prefix`
export BREW_PATH

# go用PATH指定
GOPATH=$HOME/go
export GOPATH
GOROOT=/usr/local/opt/go/libexec
export GOROOT

# lessの設定 http://qiita.com/hatchinee/items/586fb1c4915e2bb5c03b
export LESS='-gj10 --RAW-CONTROL-CHARS'

# 以下のパスについては重複を削除する
typeset -U path cdpath fpath manpath

# homebrewとcoreutils優先の設定
path=(
    # haskell packages
    # $HOME/.cabal/bin(N-/)
    # $HOME/bin(N-/)

    # 標準のツールとかもhomebrewで導入したのを優先させる
    $BREW_PATH/bin(N-/)
    $BREW_PATH/opt/ruby/bin(N-/)

    # go用PATH設定
    $GOPATH/bin
    $GOROOT/bin

    # for ruby
    $HOME/.rbenv/bin


    #デフォルトのコマンドをGNUコマンドで
    $(/usr/local/bin/brew --prefix coreutils)/libexec/gnubin(N-/)

    /usr/bin(N-/)
    /bin(N-/)
    #sbin
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    # MacOS規定のPATHを全てこちらで上書きにする？
    # $PATH
    )
export path


# # カラー設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# gnuplot等のグラフ出力先をX11に指定
export GNUTERM=x11

# # Homebrew用PATH指定
# export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:$PATH
# 
# # TeXLive用PATH指定
# export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin
# 
# # Cabal(Haskell)用設定
# export PATH=$PATH:$HOME/.cabal/bin
# 
# # rbenv,phpenv用設定
# export PATH=$HOME/.phpenv/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

# JAVA用PATH指定
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

# # NODEBREW用PATH指定
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export NODEBREW_ROOT=$HOME/.nodebrew

# PYTHON用設定（pythonbrewを使用）
# export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
# export WORKON_HOME=$HOME/.virtualenvs

# # perlbrew用環境設定
# export PATH=$PATH:$HOME/perl5/perlbrew/bin

# virtualenv settings
export WORKON_HOME=$HOME/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh

# 単語の区切り文字を指定する
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


if which rbenv > /dev/null; then
    # rbenv initがやっていること #
    # - $RBENV_ROOT/shims以下にPATHを通す
    # - rbenvへの補完関数のロード
    # - rehash
    # - その他
    eval "$(rbenv init -)"
fi
