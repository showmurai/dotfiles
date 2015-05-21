# 言語設定
export LANG=ja_JP.UTF-8

# 単語の区切り文字を指定する
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# lessの設定 http://qiita.com/hatchinee/items/586fb1c4915e2bb5c03b
export LESS='-gj10 --RAW-CONTROL-CHARS'

# homebrew のパス
BREW_PATH=`/usr/local/bin/brew --prefix`
export BREW_PATH

# rbenvのパス
export RBENV_ROOT=/usr/local/var/rbenv

# go-langのパス
GOPATH=$HOME/go
export GOPATH

# 以下のパスについては重複を削除する
typeset -U path cdpath fpath manpath

# homebrewとcoreutils優先の設定
path=(
    # rbenvで通らないパスを指定
    $RBENV_ROOT/bin(N-/)

    # homebrew $RBENV_ROOT/bin(N-/)で導入したのを優先で使用する
    $BREW_PATH/bin(N-/)

    #デフォルトのコマンドをGNUコマンドで
    $(/usr/local/bin/brew --prefix coreutils)/libexec/gnubin(N-/)
    $(/usr/local/bin/brew --prefix gnu-sed)/libexec/gnubin(N-/)

    /usr/bin(N-/)
    /bin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    )
export path

# zsh-completions の設定
fpath=(/usr/local/share/zsh-completions $fpath)

# TeXLive用PATH指定
# export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin

# Cabal(Haskell)用設定
# export PATH=$PATH:$HOME/.cabal/bin

# JAVA用PATH指定
# export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

# NODEBREW用PATH指定
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export NODEBREW_ROOT=$HOME/.nodebrew

# PYTHON用設定（pythonbrewを使用）
# export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
# export WORKON_HOME=$HOME/.virtualenvs

# perlbrew用環境設定
# export PATH=$PATH:$HOME/perl5/perlbrew/bin

# virtualenv settings
export WORKON_HOME=$HOME/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh

# rbenv initがやっていること #
# - $RBENV_ROOT/shims以下にPATHを通す
# - rbenvへの補完関数のロード
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

