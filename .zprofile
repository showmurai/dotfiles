# 言語設定
export LANG=ja_JP.UTF-8

# 単語の区切り文字を指定する
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# lessの設定
export LESS='-gj10 --RAW-CONTROL-CHARS'

# go-langのパス
export GOPATH=$HOME/go

# homebrew の初期化（他の設定より先に実行）
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_AUTO_UPDATE_SECS=60

# brew --prefix のキャッシュ（サブシェル呼び出しを最小化）
_brew_prefix="$HOMEBREW_PREFIX"

# 以下のパスについては重複を削除する
typeset -U path cdpath fpath manpath

# PATH設定
path=(
    $HOME/.anyenv/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    $HOME/.nodenv/bin(N-/)
    $HOME/.local/bin(N-/)

    # google cloud sdk のパス
    $HOME/google-cloud-sdk/bin(N-/)

    # デフォルトのコマンドをGNUコマンドで
    $_brew_prefix/opt/coreutils/libexec/gnubin(N-/)
    $_brew_prefix/opt/gnu-sed/libexec/gnubin(N-/)

    # homebrew
    $_brew_prefix/bin(N-/)
    $_brew_prefix/sbin(N-/)

    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/bin(N-/)
    /usr/sbin(N-/)
    /bin(N-/)
    /sbin(N-/)

    # go向けのパス
    $HOME/go/bin(N-/)
)
export path

# zsh-completions の設定
fpath=(
    $_brew_prefix/share/zsh-completions(N-/)
    $_brew_prefix/share/zsh/site-functions(N-/)
    $HOME/.zsh/completions(N-/)
    $fpath
)

# zsh-syntax-highlighting のパス
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$_brew_prefix/share/zsh-syntax-highlighting/highlighters

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# anyenv / nodenv / mise 初期化
if (( $+commands[anyenv] )); then eval "$(anyenv init -)"; fi
if (( $+commands[nodenv] )); then eval "$(nodenv init -)"; fi
if (( $+commands[mise] )); then eval "$(mise activate zsh)"; fi
if (( $+commands[op] )); then eval "$(op completion zsh)"; compdef _op op; fi

unset _brew_prefix
