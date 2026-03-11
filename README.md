# dotfiles

Shotaro Murai's dotfiles managed with symlinks.

## Structure

```
dotfiles/
├── .config/
│   └── ghostty/
│       └── config           # Ghostty terminal config
├── .editorconfig            # Cross-editor formatting rules
├── .gitconfig               # Git configuration
├── .tigrc                   # Tig (Git UI) config
├── .vimrc                   # Vim configuration (dpp.vim)
├── .zprofile                # Zsh profile
├── .zshrc                   # Zsh shell configuration
└── install.sh               # Setup script
```

## Setup

```bash
git clone git@github.com:showmurai/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

`install.sh` does the following:

1. Clones [dpp.vim](https://github.com/Shougo/dpp.vim) and its dependencies (requires Deno)
2. Creates symlinks for all config files to `$HOME`

## Contents

### Shell (Zsh)

- Language: `ja_JP.UTF-8`
- Editor: `vim`
- History: 1,000,000 lines
- Version managers: anyenv, nodenv, mise
- Interactive history search with **peco** (`Ctrl+R`)
- kubectl context display in prompt
- Google Cloud SDK integration
- Auto `ls` on `cd` and empty Enter

**Git aliases:**

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gs` | `git status -sb` |
| `gsd` | `git diff` |
| `gco` | `git checkout` |
| `gsw` | `git switch` |
| `gft` | `git fetch -p --all` |
| `gup` | `git pull --rebase` |
| `gad` | `git add` |
| `gci` | `git commit -v` |

### Git

- Default branch: `main`
- Pull: rebase by default
- Push: current branch
- Enhanced diff display with `diff-highlight`
- Git LFS support

### Vim

- Plugin manager: **dpp.vim** (Deno-based, lazy loading, TOML config)
- Line numbers (relative)
- Tab: 2-char display / 4-space indent
- Clipboard sharing with OS
- Emacs-style keybindings in insert mode (`Ctrl+a/e/f/b/p/n/h/d`)
- `;` and `:` swapped
- Mouse support

### EditorConfig

| Language | Style | Size |
|----------|-------|------|
| Makefile | tabs | 8 |
| Shell | spaces | 2 |
| Go | tabs | 4 |
| Python | spaces | 4 |
| JS/TS | spaces | 2 |
| C/C++ | tabs | 4 |
| Ruby | spaces | 2 |
| YAML/JSON/TOML | spaces | 2 |
| Terraform | spaces | 2 |

### Ghostty

- Theme: `catppuccin-mocha`
- Window: 200 columns x 50 lines

### Tig

- Split view height: 80%
- Diff context: 6 lines
- Custom date/author display

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- [Deno](https://deno.land/) (for dpp.vim)
- [peco](https://github.com/peco/peco)
