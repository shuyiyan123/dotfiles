# =================== Oh-My-Zsh 配置 ===================
export ZSH="$HOME/.oh-my-zsh"

# 主题设置
ZSH_THEME="clean"

# 禁用自动更新
DISABLE_AUTO_UPDATE="true"

# 插件配置
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# =================== 环境变量配置 ===================
export LANG=en_US.UTF-8

# 用户本地命令
export PATH="$HOME/.local/bin:$PATH"

# 自动建议高亮样式
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=30

# 隐藏 agnoster 等主题中的用户名@主机名（改成你的用户名）
DEFAULT_USER="your_username"

# =================== Ghostty 标题设置为当前目录 ===================
if [[ -n "${GHOSTTY_RESOURCES_DIR:-}" ]]; then
    ghostty_set_title() {
        # 将 HOME 替换为 ~，保持标题更短
        local dir="${PWD/#$HOME/~}"
        # Ghostty 支持 OSC 2 设置窗口标题
        printf '\033]2;%s\033\\' "$dir"
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd ghostty_set_title
    add-zsh-hook precmd ghostty_set_title
    add-zsh-hook preexec ghostty_set_title
    ghostty_set_title
fi

# =================== Yazi 文件管理器 ===================
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# =================== Zoxide 智能目录跳转 ===================
eval "$(zoxide init zsh)"

# =================== 终端代理（按需修改端口） ===================
# 如果你不使用本地代理，请删除或注释以下代码块
export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897
export no_proxy=localhost,127.0.0.1,::1,.oaistatic.com,oaistatic.com

# 兼容只读取大写变量名的程序
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$https_proxy"
export ALL_PROXY="$all_proxy"
export NO_PROXY="$no_proxy"
