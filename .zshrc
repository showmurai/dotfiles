# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 2行表示
#PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
#%# "

# プロンプト指定
PROMPT="
%{${fg[red]}%}[%n@%m] %{${fg[yellow]}%}%~%{${reset_color}%}
%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "

# プロンプト指定(コマンドの続き)
PROMPT2='[%n]> '

# もしかして時のプロンプト指定
# SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color} "

# ------------------------------
# General Settings
# ------------------------------
# fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export LESSCHARSET=utf-8

setopt re_match_pcre     # 表示するたびに文字列を評価、置換する
setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt auto_param_slash  # ディレクトリの補完で末尾の / を自動的に付与
# setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
#補完機能を有効にする
autoload -U compinit
compinit
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true

# 補完候補に色を付ける
## 補完リストをグループ分けする
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
# 補完候補を黄色に
zstyle ':completion:*:descriptions' format '%BCompleting%b %F{yellow}%U%d%u'

# google で検索できる
function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

# PROMPT=$tmp_prompt    # 通常のプロンプト
# PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
# RPROMPT=$tmp_rprompt  # 右側のプロンプト
# SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
# ;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

export GIT_PAGER=less
if [[ -x `whence -p lv` ]]; then
      export GIT_PAGER="lv -c"
fi

# ------alias------
alias ls='ls --color=auto -AF'
alias l='ls'
alias ll='ls -AFltr'
alias e='exit'
alias v='vim'
alias m='mvim'
alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'
alias sed='gsed'
# for tmux
alias tmux-copy='tmux save-buffer - | reattach-to-user-namespace pbcopy'

# ------git alias----
alias g='git'
alias gs='git status -sb'
alias gg='git grep -n'
alias gsd='git diff'
alias gco='git checkout'
alias gft='git fetch'
alias gre='git rebase'
alias gup='git pull --rebase'
alias ghi='git hi'
alias ghs='git hist'
alias gba='git ba'
alias gbr='git br'

alias d3='ssh smurai@10.30.138.20'
alias d3m='ssh smurai@10.30.154.22'
alias d3ssh='ssh root@10.30.105.2'
alias d3mssh='ssh root@10.30.105.1'

# cd したら自動で lsしてくれる
function chpwd() { ls }

# エンターキーを押したらlsする
alls() {
    zle accept-line
    if [[ -z "$BUFFER" ]]; then
        echo ''
        ls
    fi
}
zle -N alls
bindkey "\C-m" alls

