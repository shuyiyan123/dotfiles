#!/usr/bin/env bash
# dotfiles 安装脚本：通过符号链接把配置部署到正确位置。
# 用法：./install.sh            —— 安装全部
#       ./install.sh zsh nvim   —— 只安装指定项
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log()  { printf '\033[1;32m[dotfiles]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }

# link <源(相对仓库根)> <目标(相对 $HOME)>
link() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME/$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    if [ ! -e "$src" ]; then
        warn "跳过 $1（源不存在）"
        return
    fi
    mkdir -p "$dst_dir"

    if [ -L "$dst" ]; then
        log "已链接 $2"
    elif [ -e "$dst" ]; then
        warn "$2 已存在且不是符号链接，跳过（请手动处理）"
    else
        ln -s "$src" "$dst"
        log "已链接 $2 -> $1"
    fi
}

items=("$@")
if [ ${#items[@]} -eq 0 ]; then
    items=(zsh fastfetch ghostty nvim)
fi

for item in "${items[@]}"; do
    case "$item" in
        zsh)
            link "zsh/.zshrc" ".zshrc"
            ;;
        fastfetch)
            link "fastfetch/config.jsonc" ".config/fastfetch/config.jsonc"
            link "fastfetch/logo.png" ".config/fastfetch/logo.png"
            ;;
        ghostty)
            link "ghostty/config.ghostty" ".config/ghostty/config.ghostty"
            link "ghostty/gtk.css" ".config/ghostty/gtk.css"
            ;;
        nvim)
            link "nvim" ".config/nvim"
            ;;
        *)
            warn "未知项：$item（可选：zsh fastfetch ghostty nvim）"
            ;;
    esac
done

log "完成。部分配置依赖的额外程序见 README.md。"
