# 言語設定
export LANG=ja_JP.UTF-8

# 単語の区切り文字を指定する
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# lessの設定 http://qiita.com/hatchinee/items/586fb1c4915e2bb5c03b
export LESS='-gj10 --RAW-CONTROL-CHARS'

# anyenv のパス
export ANYENV=$HOME/.anyenv

# homebrew のパス
export BREW_PATH=`/usr/local/bin/brew --prefix`

# go-langのパス
export GOPATH=$HOME/go

# 以下のパスについては重複を削除する
typeset -U path cdpath fpath manpath

# homebrewとcoreutils優先の設定
path=(

    # anyenv 向けのパス
    # $ANYENV/bin((N-/)
    $HOME/.anyenv/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)

    # homebrew 向けのパス
    $BREW_PATH/bin(N-/)

    # google cloud sdk のパス
    $HOME/google-cloud-sdk/bin

    # デフォルトのコマンドをGNUコマンドで
    $(/usr/local/bin/brew --prefix coreutils)/libexec/gnubin(N-/)
    $(/usr/local/bin/brew --prefix gnu-sed)/libexec/gnubin(N-/)

    /usr/bin(N-/)
    /bin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)


    # go向けのパス
    $HOME/go/bin
)
export path

# zsh-completions の設定
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/completions $fpath)

# rbenv initがやっていること #
# - $RBENV_ROOT/shims以下にPATHを通す
# - rbenvへの補完関数のロード
if which anyenv > /dev/null; then eval "$(anyenv init -)"; fi

# scala
export PATH=$PATH:/usr/local/src/scala/bin
export SCALA_HOME=/usr/local/src/scala

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
