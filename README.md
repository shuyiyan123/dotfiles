# dotfiles

我的 Linux 桌面配置，包含：

| 工具 | 配置项 |
| --- | --- |
| [zsh](https://www.zsh.org/) | `.zshrc`：Oh-My-Zsh、语法高亮、自动建议、别名与函数、终端代理 |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | 系统信息展示样式 |
| [Ghostty](https://ghostty.org/) | 终端字体、配色、键位、下拉终端、GTK 样式 |
| [Neovim](https://neovim.io/) | 基于 [LazyVim](https://www.lazyvim.org/) 的完整配置 |

## 目录结构

```text
dotfiles/
├── zsh/
│   └── .zshrc
├── fastfetch/
│   └── config.jsonc
├── ghostty/
│   ├── config.ghostty
│   └── gtk.css
├── nvim/
│   ├── init.lua
│   ├── lazyvim.json
│   ├── lazy-lock.json
│   └── lua/…
├── install.sh
└── README.md
```

## 安装

克隆并运行安装脚本：

```bash
git clone https://github.com/shuyiyan123/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` 会把各配置以**符号链接**的方式链接到 `~/.config/…` 或 `~` 下。这样仓库里的文件一改，本地立刻生效，也方便 `git pull` 同步。

只安装部分配置：

```bash
./install.sh zsh nvim
```

## 依赖

仅复制配置文件不会自动安装这些程序，需要你提前装好：

- **zsh**：`zsh`、`oh-my-zsh`、`zoxide`、`yazi`，以及两个 Oh-My-Zsh 插件：

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

- **fastfetch**：`fastfetch`
- **Ghostty**：`ghostty`，以及字体 **Agave Nerd Font**（见下方）
- **Neovim**：`neovim`（LazyVim 会在首次启动时自动安装插件）

### 字体

Ghostty 配置使用 **Agave Nerd Font**，请安装对应字体，否则终端会回退到默认字体：

```bash
# 以 Arch 为例
sudo pacman -S ttf-agave-nerd
# 或从 Nerd Fonts 官网下载后放入 ~/.local/share/fonts 并刷新字体缓存
```

## 自定义

- `.zshrc` 中的 `DEFAULT_USER` 请改成你的用户名；
- 如果不用本地代理，删除 `.zshrc` 末尾的代理导出块；
- `fastfetch/config.jsonc` 里的自定义 logo 图片路径改成你自己的，或删除该行使用内置 logo。

## 卸载 / 取消链接

直接删除对应的符号链接即可，不会影响仓库文件：

```bash
rm ~/.zshrc ~/.config/fastfetch/config.jsonc
```

