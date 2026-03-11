# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない
setopt SHARE_HISTORY              # 複数のzshで履歴を共有する

# プロンプト指定
PROMPT="
%{${fg[red]}%}[%n@%m] %{${fg[yellow]}%}%~%{${reset_color}%}  %1(v|%F{green}%1v%f|)
%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "

# プロンプト指定(コマンドの続き)
PROMPT2='[%n]> '

# ------------------------------
# General Settings
# ------------------------------

export EDITOR=vim
export KCODE=u
export AUTOFEATURE=true
export LESSCHARSET=utf-8

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt auto_param_slash  # ディレクトリの補完で末尾の / を自動的に付与
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする
setopt extended_glob     # グロブ機能を拡張する
setopt re_match_pcre     # PCRE 互換の正規表現を使う
unsetopt AUTO_REMOVE_SLASH
setopt MARK_DIRS         # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
unsetopt caseglob        # ファイルグロブで大文字小文字を区別しない

# ------------------------------
# Complement
# ------------------------------

autoload -U compinit
compinit

# 1Password CLI 補完（compinit の後に実行）
if (( $+commands[op] )); then eval "$(op completion zsh)"; fi
setopt auto_list               # 補完候補を一覧で表示する
setopt auto_menu               # 補完キー連打で補完候補を順に表示する
setopt AUTO_PARAM_KEYS         # 変数名を補完する
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する

# Ctrl+A とかを有効にする
bindkey -e

# ペーストモードを無効にする
unset zle_bracketed_paste

# ------------------------------
# Look And Feel Settings
# ------------------------------

# Ls Color
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

# 補完候補に色を付ける
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /opt/homebrew/sbin /opt/homebrew/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 補完リストが多いときに尋ねない
LISTMAX=1000

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

# ------------------------------
# VCS Info
# ------------------------------

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ------------------------------
# Alias
# ------------------------------

alias ls='ls --color=auto -AF'
alias l='ls'
alias ll='ls -AFltr'
alias e='exit'
alias v='vim'
alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'

# git alias
alias g='git'
alias gs='git status -sb'
alias gg='git grep -n'
alias gsd='git diff'
alias gco='git checkout'
alias gsw='git switch'
alias gft='git fetch -p --all'
alias gre='git rebase'
alias gup='git pull --rebase'
alias ghi='git hi'
alias ghs='git hist'
alias gba='git ba'
alias gbr='git br'
alias gad='git ad'
alias gci='git commit -v'
alias gls='git ls-files'

# brew alias
alias bu='brew upgrade'
alias bc='brew cleanup --prune=all'

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

# ------------------------------
# History Search (peco)
# ------------------------------

if (( $+commands[peco] )); then
  function peco-select-history() {
      BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | peco --query "$LBUFFER")
      CURSOR=$#BUFFER
      zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

# ------------------------------
# Kubernetes
# ------------------------------

if [ -f /opt/homebrew/etc/zsh-kubectl-prompt/kubectl.zsh ]; then
  source /opt/homebrew/etc/zsh-kubectl-prompt/kubectl.zsh
  RPROMPT='%{$fg[yellow]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
fi

# ------------------------------
# Google Cloud SDK
# ------------------------------

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
